//
//  ContentView.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 23/02/2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: PresetsView(), label: {
                Text("Question 1 - Image Filters")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

            })
            
            NavigationLink(destination: ImagePickerView(), label: {
                Text("Question 2 - Collage")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.pink)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(.top, 20)
            
            NavigationLink(destination: ImageEditingView(), label: {
                Text("Question 3 - Whatsapp Status")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(.top, 20)
            
        }
    }
}

#Preview {
    ContentView()
}
