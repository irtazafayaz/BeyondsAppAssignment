//
//  ImagePickerView.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import SwiftUI

struct ImagePickerView: View {
    
    @ObservedObject var viewModel = ImagePickerVM()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Path { path in
                    path.move(to: CGPoint(x: Constants.boxWidth * 0.70 , y: 0))
                    path.addLine(to: CGPoint(x: Constants.boxWidth * 0.50, y: geometry.size.height))
                    
                }
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [1]))
                .foregroundColor(.black)
                
                if let leftImage = viewModel.leftImage {
                    Image(uiImage: leftImage)
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(CustomClipShape(direction: .left))
                }
                
                if let rightImage = viewModel.rightImage {
                    Image(uiImage: rightImage)
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(CustomClipShape(direction: .right))
                }
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.activeSelection = .left
                        self.viewModel.showingImagePicker = true
                    }
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.viewModel.activeSelection = .right
                        self.viewModel.showingImagePicker = true
                    }
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                    .offset(x: geometry.size.width / 2)
            }
            .border(Color.black, width: 2)
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            if let activeSelection = viewModel.activeSelection {
                switch activeSelection {
                case .left:
                    ImagePicker(image: self.$viewModel.leftImage)
                case .right:
                    ImagePicker(image: self.$viewModel.rightImage)
                }
            }
        }
        .frame(width: Constants.boxWidth, height: Constants.boxHeight)
    }
}

#Preview {
    ImagePickerView()
}
