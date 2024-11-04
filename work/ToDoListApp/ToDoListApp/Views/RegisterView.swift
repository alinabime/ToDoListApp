//
//  RegisterView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject  var viewModel = RegisterViewModel()
  
    var body: some View {
        VStack {
            HeaderView(title: "Register"
                       , subtitle: "Start organazing todos"
                       , backgroundColor: .orange
                       , angle: -15)
            Form {
                TextField("first name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email address", text: $viewModel.email)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                             
                             
     
                
                TLButtonView(title: "craete account", backgroundColor: .green){
                    viewModel.register()
                } .padding()
            }
            
           
           
            
            Spacer()
        }
    }
}
                   
#Preview {
    RegisterView()
}
