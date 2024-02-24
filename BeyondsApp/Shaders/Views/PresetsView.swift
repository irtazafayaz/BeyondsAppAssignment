//
//  PresetsView.swift
//  BeyondsApp
//
//  Created by Irtaza Fiaz on 24/02/2024.
//

import SwiftUI

struct PresetsView: View {
    
    @State var selectedEffect: ImageEffect = .none
    
    var body: some View {
        VStack {
            
            Image("boy")
                .resizable()
                .scaledToFit()
                .applyEffect(effect: selectedEffect)
                .frame(height: 500)
            
            Spacer()
            
            HStack(spacing: 20) {
                ForEach(ImageEffect.allCases, id: \.self) { effect in
                    Image("boy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .applyEffect(effect: effect)
                        .onTapGesture {
                            selectedEffect = effect
                        }
                }
            }
            .padding()
            
        }
    }
}


#Preview {
    PresetsView()
}
