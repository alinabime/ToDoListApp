//
//  RegisterView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct RegisterView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            HeaderView(title: "Register"
                       , subtitle: "Start organazing todos"
                       , backgroundColor: .orange
                       , angle: -15)
            Form {
                TextField("Full name", text: $name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email address", text: $email)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .textFieldStyle(DefaultTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButtonView(title: "craete account", backgroundColor: .green){
                    //aatemp registration
                } .padding()
            } .offset(y: -50)
            
           
           
            
            Spacer()
        }
    }
}
                   
#Preview {
    RegisterView()
}
