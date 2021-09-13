//
//  ScienceApp.swift
//  Science
//
//  Created by Abhiram Nagadi on 12/09/21.
//

import SwiftUI

@main
struct ScienceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
