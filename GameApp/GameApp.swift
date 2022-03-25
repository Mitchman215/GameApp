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
            TabView {
                GameSelectionView()
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Games")
                    }
                
                Text("Profile tab")
                    .tabItem {
                        Image(systemName: "person")
                        Text("Stats")
                    }
            }
//            SetView(theGame: game)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
