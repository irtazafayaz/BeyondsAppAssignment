//
//  ImagePickerView.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import SwiftUI

struct ImagePickerView: View {
    
    @State private var leftImage: UIImage?
    @State private var rightImage: UIImage? = UIImage(named: "boy")
    @State private var showingImagePicker = false
    @State private var activeSelection: ActiveSelection?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [1]))
                .foregroundColor(.black)
                
                // MARK: Left Image
                
                if let leftImage = leftImage {
                    Image(uiImage: leftImage)
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(CustomClipShape(direction: .left))
                    
                    
                }
                
                // MARK: Right Image
                if let rightImage = rightImage {
                    Image(uiImage: rightImage)
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipShape(CustomClipShape(direction: .right))
                }
                
                
                // Tap gestures for each half
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.activeSelection = .left
                        self.showingImagePicker = true
                    }
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.activeSelection = .right
                        self.showingImagePicker = true
                    }
                    .frame(width: geometry.size.width / 2, height: geometry.size.height)
                    .offset(x: geometry.size.width / 2)
            }
            .border(Color.black, width: 2)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$leftImage, selection: $activeSelection)
        }
        .frame(width: 300, height: 500)
    }
}

#Preview {
    ImagePickerView()
}
