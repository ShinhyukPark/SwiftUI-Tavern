//
//  CoreData_TodoListApp.swift
//  CoreData-TodoList
//
//  Created by Shinhyuk Park on 6/11/24.
//

import SwiftUI

@main
struct CoreData_TodoListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
