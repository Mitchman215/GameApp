//
//  MemorizeView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/15/22.
//

import SwiftUI

struct MemorizeView: View {
    enum theme: CaseIterable {
        case vehicles, fruits, animals
        
        var emojis: [String] {
            switch(self) {
            case .vehicles: return ["🚕", "🚗", "🚙", "🚌", "🚎", "🏎", "🚜", "🚑"]
            case .fruits: return ["🍑", "🍎", "🍉", "🍌", "🍓", "🍐", "🍍", "🍊"]
            case .animals: return ["🐒", "🦄", "🦉", "🐘", "🐖", "🐿", "🦧", "🦍"]
            }
        }
        
        var iconName: String {
            switch(self) {
            case .vehicles: return "car"
            case .fruits: return "fork.knife"
            case .animals: return "pawprint"
            }
        }
        
        var themeName: String {
            switch(self) {
            case .vehicles: return "Vehicles"
            case .fruits: return "Fruits"
            case .animals: return "Animals"
            }
        }
    }
    
    @State private var selectedTheme: theme?
    private var emojis: [String] {
        selectedTheme?.emojis.shuffled() ?? []
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .bold()
                .font(.largeTitle)
            
            if selectedTheme == nil {
                Spacer()
                Text("Select a theme from below!")
                    .font(.title)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(emojis, id: \.self) { emoji in
                            CardView(content: emoji)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(.red)
            }
            
            Spacer()
            
            HStack {
                ForEach(theme.allCases, id: \.self) { theme in
                    Button {
                        selectedTheme = theme
                    } label: {
                        ZStack {
                            VStack {
                                Image(systemName: theme.iconName)
                                    .font(.largeTitle)
                                Text(theme.themeName)
                                    .font(.body)
                            }
                            .padding()
                        }
                    }

                }
            }
        }
        .padding(.horizontal)
    }
}



struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}




struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
        MemorizeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
