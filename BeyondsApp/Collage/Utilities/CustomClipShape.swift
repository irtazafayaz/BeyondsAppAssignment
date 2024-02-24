//
//  CustomClipShape.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import Foundation
import SwiftUI

enum ActiveSelection {
    case left, right
}

struct CustomClipShape: Shape {
    
    let direction: ActiveSelection
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: direction == .left ? rect.minX : rect.maxX, y: direction == .left ? rect.maxY : rect.minY))
        path.closeSubpath()

        return path
    }
}


