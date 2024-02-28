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
    @Published var textToAdd = "HHHHHHHHHHHHHHHHHH"
    @Published var textColor = Color.yellow
    @Published var showingColorPicker = false

    @Published var textFieldPosition: CGPoint = CGPoint(x: 100, y: 100)
    
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

