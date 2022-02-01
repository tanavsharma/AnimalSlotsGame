//
//  ContentView.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-01.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack{
            
            //MAIN USER INTERFACE
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5) {
                // HEADER - APP LOGO
                LogoView()
                Spacer()
                
                //JACKPOT
                HStack{
                    Text("JACKPOT".uppercased())
                        .numberStyle()

                        .multilineTextAlignment(.trailing)
                    
                    Text("$25,000")
                        .numberStyle()
                        .layoutPriority(1)
                }
                
                .padding(.horizontal, 16)
                .frame(minWidth: 128)
                .background(
                    Capsule()
                        .foregroundColor(Color("informationBg"))
                )
                
                // SLOTS
                VStack(alignment: .center, spacing: 0){
                    
                    // Slot 1
                    ZStack{
                        SlotsView()
                        Image("slotframe")
                            .resizable()
                            .modifier(ImageModifier())
                            
                    }
                    
                    HStack(alignment: .center, spacing: 0){
                        
                        ZStack{
                            SlotsView()
                            Image("slotframe")
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                        Spacer()
                        
                        ZStack{
                            SlotsView()
                            Image("slotframe")
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                    }
                    
                    // Slot 2
                    
                    // Slot 3
                    
                    // Spin Button
                    
                }
                .layoutPriority(2)
                
                // FUNCTIONS
               
                // USER INFORMATION
                HStack{
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .labelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("2500")
                            .numberStyle()
                            .layoutPriority(1)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 128)
                    .background(
                        Capsule()
                            .foregroundColor(Color("informationBg"))
                    )
                    
                    Spacer()
                    
                    HStack{
                        Text("100")
                            .numberStyle()
                            .layoutPriority(1)
                        
                        Text("Your\nBet".uppercased())
                            .labelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                    .frame(minWidth: 128)
                    .background(
                        Capsule()
                            .foregroundColor(Color("informationBg"))
                        
                    )
                }
                
                
                // FOOTER
                
                Spacer()
            }
            // BUTTONS
            .padding()
            .frame(maxWidth: 720)
            
            //POP-UP
        }
        // BACKGROUND
        .background(Image("background"))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
