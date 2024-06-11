//
//  CoreData_TodoApp.swift
//  CoreData-Todo
//
//  Created by Shinhyuk Park on 6/11/24.
//

import SwiftUI

@main
struct CoreData_TodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
