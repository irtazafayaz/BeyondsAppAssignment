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
    @Published var editedImage: UIImage? = UIImage(named: "boy")
    @Published var textToAdd = ""
    @Published var textColor = Color.yellow
    @Published var showingColorPicker = false
    @Published var showTextField = false

    @Published var offset = CGSize.zero
    @Published var currentOffset = CGSize.zero
    
}
