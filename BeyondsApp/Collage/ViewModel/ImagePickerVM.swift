//
//  ImagePickerVM.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import Foundation
import SwiftUI
import Combine

class ImagePickerVM: ObservableObject {

    @Published var leftImage: UIImage?
    @Published var rightImage: UIImage?
    @Published var showingImagePicker = false
    @Published var activeSelection: ActiveSelection?
    
    func selectImage(for selection: ActiveSelection) {
        self.activeSelection = selection
        self.showingImagePicker = true
    }
    
    func loadImage(for selection: ActiveSelection?, image: UIImage?) {
        guard let selection = selection else { return }
        switch selection {
        case .left:
            leftImage = image
        case .right:
            rightImage = image
        }
        showingImagePicker = false
    }
}
