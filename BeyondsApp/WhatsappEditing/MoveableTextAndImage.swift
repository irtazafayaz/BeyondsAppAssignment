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
                    .frame(width: 200, height: 50)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(5)
                    .padding(4)
                    .position(x: viewModel.textFieldPosition.x, y: viewModel.textFieldPosition.y)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newLocation = value.location
                                let minX = geometry.size.width * TextfieldBounds.min.rawValue
                                let maxX = geometry.size.width * TextfieldBounds.max.rawValue
                                let minY = geometry.size.height * TextfieldBounds.min.rawValue
                                let maxY = geometry.size.height * TextfieldBounds.max.rawValue
                                
                                let boundedX = min(max(newLocation.x, minX), maxX)
                                let boundedY = min(max(newLocation.y, minY), maxY)
                                
                                self.viewModel.textFieldPosition = CGPoint(x: boundedX, y: boundedY)
                            }
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
