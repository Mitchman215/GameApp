//
//  GameAppApp.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import SwiftUI

@main
struct GameApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
