//
//  Diamond.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/25/22.
//

import SwiftUI

/// A diamond shape
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: 0))
        p.addLine(to: CGPoint(x: 0, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        return p
    }
}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
