//
//  UIView+Extensions.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 28/02/2024.
//

import Foundation
import SwiftUI

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
