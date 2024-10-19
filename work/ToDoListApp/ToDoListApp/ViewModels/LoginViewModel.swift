//
//  LoginViewModel.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var mail: String = ""
    @Published var password: String = ""
    init() {}
}
