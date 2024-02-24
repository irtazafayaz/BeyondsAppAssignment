//
//  ViewExtension.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import Foundation
import SwiftUI

extension View {
    func applyEffect(effect: ImageEffect) -> some View {
        switch effect {
        case .none:
            return AnyView(self)
        case .checkerboard:
            return AnyView(self.colorEffect(ShaderLibrary.checkerboard(.color(.blue),.float(5))))
        case .emboss:
            return AnyView(self.layerEffect(ShaderLibrary.emboss(.float(50)), maxSampleOffset: .zero))
        case .infrared:
            return AnyView(self.colorEffect(ShaderLibrary.infrared()))
        case .interlace:
            return AnyView(self.colorEffect(ShaderLibrary.interlace(.float(10), .color(.blue), .float(10))))
        }
    }
}
