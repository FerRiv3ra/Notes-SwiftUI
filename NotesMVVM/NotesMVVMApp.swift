//
//  NotesMVVMApp.swift
//  NotesMVVM
//
//  Created by Fernando Rivera on 22/10/23.
//

import SwiftUI

@main
struct NotesMVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
