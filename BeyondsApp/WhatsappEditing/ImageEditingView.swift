//
//  ImageEditingView.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 25/02/2024.
//

import SwiftUI

struct ImageEditingView: View {
    
    @ObservedObject private var viewModel = ImageEditingViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                MoveableTextAndImage(viewModel: viewModel)
                
                ColorPicker("Change text color", selection: $viewModel.textColor)
                    .padding()
                
                Button("Save to gallery") {
                    viewModel.captureView {
                        UIImageWriteToSavedPhotosAlbum($0, nil, nil, nil)
                    }
                }
            }
        }
    }
    
}

#Preview {
    ImageEditingView()
}

