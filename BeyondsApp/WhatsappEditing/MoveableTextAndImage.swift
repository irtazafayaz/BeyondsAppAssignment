//
//  MoveableTextAndImage.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 28/02/2024.
//

import SwiftUI

struct MoveableTextAndImage: View {
    
    @ObservedObject var viewModel: ImageEditingViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                if let image = viewModel.editedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                
                TextField("", text: $viewModel.textToAdd)
                    .frame(width: 100, height: 50)
                    .foregroundColor(viewModel.textColor)
                    .background(.black)
                    .cornerRadius(5)
                    .padding(4)
                    .position(x: viewModel.textFieldPosition.x, y: viewModel.textFieldPosition.y)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.viewModel.updateTextFieldPosition(dragValue: value, parentSize: geometry.size)
                            }
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
