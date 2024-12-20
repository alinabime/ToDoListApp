//
//  ProfileView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack {
                //Header
                HeaderView(title: "To Do List", subtitle: "Get things done", backgroundColor: .pink, angle: 15)
                
                //Login form
                Form {
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Email Address",text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButtonView(title: "Login", backgroundColor: .blue) {
                        viewModel.login()
                    } .padding()
                } .offset(y: -50)
                
                //create Acount
                VStack {
                    Text("New here or returning?")
                    NavigationLink("Create An Acount", destination: RegisterView())
                   
                }
            
        
        }
        
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}

