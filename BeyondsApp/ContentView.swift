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
            NavigationLink("Image Filters") {
                PresetsView()
            }
            NavigationLink("Collage") {
                ImagePickerView()
            }
            NavigationLink("Whatsapp Status Screen") {
                ImageEditingView()
            }
        }
    }
}

#Preview {
    ContentView()
}
