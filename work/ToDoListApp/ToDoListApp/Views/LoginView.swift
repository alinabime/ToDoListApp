//
//  ProfileView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct LoginView: View {
    @State var mail: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            VStack {
                //Header
                HeaderView(title: "To Do List", subtitle: "Get things done", backgroundColor: .pink, angle: 15)
                
                //Login form
                Form {
                    TextField("Email Address",text: $mail)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    Button {
                        //attempt to log in
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.blue)
                            
                            Text("Login")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                } .offset(y: -50)
                
                //create Acount
                VStack {
                    Text("New here or returning?")
                    NavigationLink("Create An Acount", destination: RegisterView())
                   
                }
                .padding(.bottom, 50)
        
        }
        
            Spacer()
        }
    }
}

#Preview {
    LoginView()
}

