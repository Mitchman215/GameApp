//
//  SelectionView.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/5/22.
//

import SwiftUI

struct SelectionView: View {
    var body: some View {
        VStack {
            Text("Select a game to play")
                .bold()
                .padding(.top, 40)
                .font(.title)
            GeometryReader { geo in
                
            }
            
        }
        
        
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView()
    }
}
