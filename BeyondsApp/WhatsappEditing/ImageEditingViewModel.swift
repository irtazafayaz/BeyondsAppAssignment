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
    @Published var showingColorPicker = false
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
        let view = MoveableTextAndImage(viewModel: self)
        let controller = UIHostingController(rootView: view)
        UIApplication.shared.windows.first?.rootViewController?.view.addSubview(controller.view)
        controller.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let image = controller.view.asImage()
            completion(image)
            controller.view.removeFromSuperview()
        }
    }
    
}

extension Color {
    func uiColor() -> UIColor {
        return UIColor(self)
    }
}

