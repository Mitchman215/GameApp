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
    
    private let game = EmojiConcentration()

    var body: some Scene {
        WindowGroup {
            EmojiConcentrationView(theGame: game)
//            SetView(theGame: game)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
