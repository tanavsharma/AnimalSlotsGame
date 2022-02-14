//
//  InformationView.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-14.
//

import SwiftUI

struct InformationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            LogoView()
            
            Spacer()
        }
        .padding()
        .background(Image("background"))
        .overlay(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "chevron.left")
            }
            .font(.title)
            .accentColor(Color.white),
            alignment: .topLeading
        )
        .padding()
    }
    
    
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
