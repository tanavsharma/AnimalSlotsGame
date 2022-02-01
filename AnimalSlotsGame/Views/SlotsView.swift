//
//  SlotsView.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-01.
//

import SwiftUI

struct SlotsView: View {
    var body: some View {
        Image("slotframe")
            .resizable()
            .modifier(ImageModifier())
    }
}

struct SlotsView_Previews: PreviewProvider {
    static var previews: some View {
        SlotsView()
            .previewLayout(.fixed(width: 220, height: 220))
    }
}
