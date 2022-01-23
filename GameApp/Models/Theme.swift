//
//  Theme.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/23/22.
//

import Foundation

struct Theme {
    let name: String
    let emojis: [String]
    let color: String
    let numberOfStartingPairs: Int
    
    init(name: String, emojis: [String], color: String, numberOfStartingPairs: Int = Int.max) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfStartingPairs = min(numberOfStartingPairs, emojis.count)
    }
    
    static let defaults = [
        Theme(name: "Vehicles", emojis: ["🚕", "🚗", "🚙", "🚌", "🚎", "🏎", "🚜", "🚑", "🚲", "✈️", "🚤", "🛸", "🛺"],
              color: "orange", numberOfStartingPairs: 11),
        Theme(name: "Fruits", emojis: ["🍑", "🍎", "🍉", "🍌", "🍓", "🍐", "🍍", "🍊", "🥝"], color: "yellow"),
        Theme(name: "Animals", emojis: ["🐒", "🦄", "🦉", "🐘", "🐖", "🐿", "🦧", "🦍", "🦅", "🐢"], color: "red"),
        Theme(name: "Sports", emojis: ["⚽️", "🏓", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏆", "🏒"], color: "green"),
        Theme(name: "Flags", emojis: ["🇩🇪", "🇯🇵", "🇰🇷", "🇷🇺", "🇬🇧", "🇺🇸", "🇫🇷", "🇨🇳", "🇮🇳", "🇮🇩", "🇳🇵"], color: "blue"),
        Theme(name: "Tools", emojis: ["🪚", "🛠", "🪓", "⛏", "🪛", "🔦", "🧰"], color: "brown")
    ]
}
