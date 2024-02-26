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
        GeometryReader { geometry in
            VStack {
                if let editedImage = viewModel.editedImage {
                    Image(uiImage: editedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.70)
                        .overlay(
                            TextField("Enter Text", text: $viewModel.textToAdd)
                                .font(.headline)
                                .foregroundStyle(viewModel.textColor)
                                .padding()
                                .offset(
                                    x: viewModel.offset.width + viewModel.currentOffset.width,
                                    y: viewModel.offset.height + viewModel.currentOffset.height
                                )
                                .padding()
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            let proposedOffset = CGSize(
                                                width: viewModel.offset.width + gesture.translation.width,
                                                height: viewModel.offset.height + gesture.translation.height
                                            )
                                            let horizontalBounds = geometry.size.width
                                            let verticalBounds = geometry.size.height * 0.70
                                            
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
                
                Button {
                    viewModel.showingImagePicker = true
                } label: {
                    Text(viewModel.editedImage != nil ? "Change Image" : "Pick Image")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                .sheet(isPresented: $viewModel.showingImagePicker) {
                    ImagePicker(image: $viewModel.editedImage)
                }
                
                if viewModel.editedImage != nil {
                    ColorPicker("Change added text color", selection: $viewModel.textColor)
                        .padding()
                }
            }
            .sheet(isPresented: $viewModel.showingColorPicker) {
            }
        }
        
    }
    
}

#Preview {
    ImageEditingView()
}

