//
//  CPSC_411A_Milestone_2App.swift
//  CPSC_411A_Milestone_2
//
//  Created by csuftitan on 11/15/26.
//

import SwiftUI
import CoreData

@main
struct CPSC_411A_Milestone_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
