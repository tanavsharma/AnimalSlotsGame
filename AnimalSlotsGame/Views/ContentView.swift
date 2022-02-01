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
                
                Spacer()
                
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
                        // SLot 2
                        ZStack{
                            SlotsView()
                            Image("slotframe")
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                        Spacer()
                        // SLot 3
                        ZStack{
                            SlotsView()
                            Image("slotframe")
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                    }
                    
                    
                    
                    
                    // Spin Button
                    Button(action: {
                        print("Spining Slots")
                    }){
                        Image("spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
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
                
                HStack{
                    
                    HStack{
                        //Button - Bet 10
                        Button(action: {
                            print("You bet 10!")
                        }){
                            Text("Press\nTo Bet")
                                .labelStyle()
                                .multilineTextAlignment(.trailing)
                            
                            Text("10")
                                .numberStyle()
                                .layoutPriority(1)
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .frame(minWidth: 128)
                        .background(
                            Capsule()
                                .foregroundColor(Color("informationBg"))
                        )
                        
                    }
                    
                    Spacer()
                    
                    HStack{
                        //Button - Bet 100
                        Button(action: {
                            print("You bet 100!")
                        }){
                            Text("100")
                                .numberStyle()
                                .layoutPriority(1)
                            
                            Text("Press\nTo Bet")
                                .labelStyle()
                                .multilineTextAlignment(.leading)
                            
                            
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .frame(minWidth: 128)
                        .background(
                            Capsule()
                                .foregroundColor(Color("informationBg"))
                        )
                        
                    }
                    
                }
                Spacer()
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
