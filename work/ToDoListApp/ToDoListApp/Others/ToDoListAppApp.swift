//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by alinabi on 10/14/24.
//

import SwiftUI
import FirebaseCore
@main
struct ToDoListAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
