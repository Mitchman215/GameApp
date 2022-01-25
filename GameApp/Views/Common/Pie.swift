//
//  Pie.swift
//  GameApp
//
//  Created by Mitchell Salomon on 1/24/22.
//

import SwiftUI

/// A pie chart shape
struct Pie: Shape {
    /// The angle to start the pie shape at
    var startAngle: Angle
    /// The angle to finish the pie shape at
    var endAngle: Angle
    /// Whether to draw the pie shape in a clockwise direction
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        // note: we negate clockwise to accomodate the upward-view users think of when specifying clockwise
        p.addLine(to: center)
        
        return p
    }
    
}

struct Pie_Previews: PreviewProvider {
    static var previews: some View {
        Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 120))
    }
}
