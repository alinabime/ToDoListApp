import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    
    private var debounceWorkItem: DispatchWorkItem?

    init() {}

    func register() {
        guard validate() else { return }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] resault, error in
            guard let user = resault?.user.uid else {
                self?.errorMessage = "Failed to register."
                return
            }
            self?.insertUserRecord(id: user)
        }
    }
    private func insertUserRecord(id: String) {
        let newUser = user(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        db.collection("user")
            .document("id")
            .setData(newUser.asDictinary())
    }
    
    func onEmailChanged() {
            debounceWorkItem?.cancel()
            debounceWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                if !self.isEmailValid() {
                    self.errorMessage = "Invalid email format."
                } else {
                    self.errorMessage = ""
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: debounceWorkItem!)
        }

    func isEmailValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isPasswordValid() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    func isConfirmPasswordValid() -> Bool {
        return password == confirmPassword
    }

    private func validate() -> Bool {
        errorMessage = ""

        if email.isEmpty {
            errorMessage = "Please enter your email"
            return false
        }
        if !isEmailValid() {
            errorMessage = "Please enter a valid email"
            return false
        }
        if password.isEmpty {
            errorMessage = "Please enter your password"
            return false
        }
        if !isPasswordValid() {
            errorMessage = "Password must be at least 8 characters, contain an uppercase letter, lowercase letter, a number, and a special character."
            return false
        }
        if confirmPassword.isEmpty {
            errorMessage = "Please confirm your password"
            return false
        }
        if !isConfirmPasswordValid() {
            errorMessage = "Passwords do not match"
            return false
        }
        return true
    }
    private func handleFirebaseError(_ error: NSError) {
        switch AuthErrorCode(rawValue: error.code) {
        case .emailAlreadyInUse:
            errorMessage = "Email already in use"
        case .invalidEmail:
            errorMessage = "Invalid email"
        case .weakPassword:
            errorMessage = "Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character"
        default:
            errorMessage = error.localizedDescription
        }
    }


}
