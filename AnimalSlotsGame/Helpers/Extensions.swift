//
//  Extensions.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-01.
//

import SwiftUI

extension Text {
    func labelStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func highStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(size: 12, weight: .bold, design: .rounded))
    }
    
    func numberStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
