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
        VStack {
            
            if let editedImage = viewModel.editedImage {
                Image(uiImage: editedImage)
                    .scaledToFit()
                    .frame(width: viewModel.imageSize.width, height: viewModel.imageSize.height)
                    .overlay(
                        TextField("Enter Text", text: $viewModel.textToAdd)
                            .font(.headline)
                            .foregroundColor(viewModel.textColor)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(10)
                            .offset(
                                x: viewModel.offset.width + viewModel.currentOffset.width,
                                y: viewModel.offset.height + viewModel.currentOffset.height
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        let proposedOffset = CGSize(
                                            width: viewModel.offset.width + gesture.translation.width,
                                            height: viewModel.offset.height + gesture.translation.height
                                        )
                                        let horizontalBounds = (viewModel.imageSize.width / 2) - (viewModel.textWidth / 2)
                                        let verticalBounds = (viewModel.imageSize.height / 2) - (viewModel.textHeight / 2)

                                        self.viewModel.currentOffset.width = max(min(proposedOffset.width, horizontalBounds), -horizontalBounds)
                                        self.viewModel.currentOffset.height = max(min(proposedOffset.height, verticalBounds), -verticalBounds)
                                    }
                                    .onEnded { gesture in
                                        viewModel.offset = viewModel.currentOffset
                                        viewModel.currentOffset = .zero
                                    }
                            )
                    )
            } else {
                Text("Pick an image to start editing")
                    .padding()
            }
            
            
            Button("Pick Image") {
                viewModel.showingImagePicker = true
            }
            .padding()
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.editedImage)
            }
            
            if viewModel.editedImage != nil {
                
                Button("Change Text Color") {
                    viewModel.showingColorPicker = true
                }
                .padding()
                .sheet(isPresented: $viewModel.showingColorPicker) {
                    ColorPicker("Pick a color", selection: $viewModel.textColor)
                }
            }
        }
    }
    
}

#Preview {
    ImageEditingView()
}

