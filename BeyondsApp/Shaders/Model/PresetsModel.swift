//
//  PresetsModel.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import Foundation

enum ImageEffect: CaseIterable {
   
    case none, checkerboard, emboss, infrared, interlace

    var displayName: String {
        switch self {
        case .none: return "None"
        case .checkerboard: return "Checkerboard"
        case .emboss: return "Emboss"
        case .infrared: return "Infrared"
        case .interlace: return "Interlace"
        }
    }
}
