//
//  MilestoneProjectsApp.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/26/21.
//

import SwiftUI

@main
struct MilestoneProjectsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
