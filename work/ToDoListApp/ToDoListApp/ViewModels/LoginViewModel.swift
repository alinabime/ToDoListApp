import FirebaseAuth
import Foundation


class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    private var debounceWorkItem: DispatchWorkItem?
    
    init() {}

    // Validate the email format using regex
    func isEmailValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    // Strong password validation with uppercase, lowercase, digit, and special character requirements
    func isPasswordValid() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[!@#$%^&*])[A-Za-z\\d!@#$%^&*]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

    // This method will be called whenever the email input changes
    func onEmailChanged() {
        debounceEmailValidation()
    }

    // Debouncing email validation: only trigger the validation after 300ms of no input
    private func debounceEmailValidation() {
        debounceWorkItem?.cancel()  // Cancel the previous debounce work, if any
        
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
    
    // Login function using Firebase Auth
    func login() {
        guard validate() else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authDataResult, error) in
            if let error = error as NSError? {
                // Handle different error cases for better user feedback
                switch AuthErrorCode(rawValue: error.code) {
                case .wrongPassword:
                    self?.errorMessage = "The password you entered is incorrect."
                case .invalidEmail:
                    self?.errorMessage = "The email format is incorrect. Please check and try again."
                case .userNotFound:
                    self?.errorMessage = "No account found with this email. Please sign up."
                default:
                    self?.errorMessage = error.localizedDescription
                }
            } else {
                self?.errorMessage = "Login successful!"
            }
        }
    }
    
    // Validation function with detailed error messages for each field
    private func validate() -> Bool {
        errorMessage = ""
        
        if email.isEmpty {
            errorMessage = "Please enter your email."
            return false
        }
        
        if !isEmailValid() {
            errorMessage = "Please enter a valid email address."
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Please enter your password."
            return false
        }
        
        if !isPasswordValid() {
            errorMessage = "Password must be at least 8 characters long and contain an uppercase letter, lowercase letter, a number, and a special character."
            return false
        }
        
        return true
    }
}
