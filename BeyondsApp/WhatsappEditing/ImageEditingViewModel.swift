//
//  ImageEditingViewModel.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 26/02/2024.
//

import Foundation
import SwiftUI

class ImageEditingViewModel: ObservableObject {
    
    @Published var showingImagePicker = false
    @Published var editedImage: UIImage?
    @Published var textToAdd = "Your text here"
    @Published var textColor = Color.yellow
    @Published var showingColorPicker = false
    
    @Published var offset = CGSize.zero
    @Published var currentOffset = CGSize.zero
    
    let textWidth: CGFloat = 100
    let textHeight: CGFloat = 50
    let imageSize = CGSize(width: 300, height: 500)
    
    
}
