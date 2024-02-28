//
//  ImageEditingViewModel.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 26/02/2024.
//

import Foundation
import UIKit
import SwiftUI

class ImageEditingViewModel: ObservableObject {
    
    @Published var editedImage: UIImage? = UIImage(named: "boy")
    @Published var textToAdd = "Hello There"
    @Published var textColor = Color.yellow
    @Published var textFieldPosition: CGPoint = CGPoint(x: 100, y: 100)
    
    func updateTextFieldPosition(dragValue: DragGesture.Value, parentSize: CGSize) {
        let newLocation = dragValue.location
        let minX = parentSize.width * TextfieldBounds.min.rawValue
        let maxX = parentSize.width * TextfieldBounds.max.rawValue
        let minY = parentSize.height * TextfieldBounds.min.rawValue
        let maxY = parentSize.height * TextfieldBounds.max.rawValue
        
        let boundedX = min(max(newLocation.x, minX), maxX)
        let boundedY = min(max(newLocation.y, minY), maxY)
        
        self.textFieldPosition = CGPoint(x: boundedX, y: boundedY)
    }
    
    func captureView(completion: @escaping (UIImage) -> Void) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        let view = UIHostingController(rootView: MoveableTextAndImage(viewModel: self)).view
        window.addSubview(view!)
        view?.frame = window.frame
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let renderer = UIGraphicsImageRenderer(bounds: view!.bounds)
            let image = renderer.image { ctx in
                view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
            }
            completion(image)
            view?.removeFromSuperview()
        }
    }

    
}

extension Color {
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}

