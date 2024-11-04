//
//  User.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import Foundation
struct user: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
