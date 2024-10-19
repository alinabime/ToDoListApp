//
//  RegisterView.swift
//  ToDoListApp
//
//  Created by alinabi on 10/17/24.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        VStack {
            HeaderView(title: "Register"
                       , subtitle: "Start organazing todos"
                       , backgroundColor: .orange
                       , angle: -15)
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
