//
//  ContentView.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-01.
//

import SwiftUI

struct ContentView: View {
    
    //Create Array to Hold all the slot images
    
    let images = ["sloth","sloth","monkey","lion","lion", "racoon","seven"]
    
    @State private var showingAlert = false
    @State private var coins: Int = 2500
    @State private var betAmount: Int = 10
    @State private var showingModal: Bool = false
    @State private var disabledBtn: Bool = false
    
    
    /* Creating an array for each slot:
     * Index 0 = Slot On Top
     * Index 1 = Slot On Bottom Left
     * Index 2 = Slot On Bottom Right
     */
    @State private var slots: Array = [0,1,2]
    
    /* Functions which will handle the following:
     * 1. Spin the slots
     * 2. Check to see if the player won
     * 3. Display message if player wins, and update coin count
     * 4. End game if player loses all coins, or doesnt have enough funds
     */
    
    
    // 1. Spin the slots
    func spinSlots(){
        slots = slots.map({ _ in
            Int.random(in: 0...images.count - 1)
        })
    }
    
    // 2. Check To See if the player won
    func checkWinning(){
        if slots[0] == slots[1] && slots[1] == slots[2] && slots[0] == slots[2] {
            // 3. Display Message if player wins and adjust coins
            self.playerWins()
        }else{
            // Player Looses
            playerLoses()
        }
        
    }
    
    func playerWins(){
        coins += betAmount * 10
    }
    
    func playerLoses(){
        coins -= betAmount
    }
    
    // Game Over Popup
    func gameOver(){
        if coins <= 0{
            //Modal Window
            showingModal = true
            
            //
        }
        
        
        
        
    }
    
    
    
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
                
                //SLOTS
                VStack(alignment: .center, spacing: 0){
                    
                    // Slot 1
                    ZStack{
                        SlotsView()
                        Image(images[slots[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            
                    }
                    
                    HStack(alignment: .center, spacing: 0){
                        // SLot 2
                        ZStack{
                            SlotsView()
                            Image(images[slots[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                        Spacer()
                        // SLot 3
                        ZStack{
                            SlotsView()
                            Image(images[slots[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                    }
                    
                    // Spin Button
                    Button(action: {
                        print("Spining Slots")
                        //Spin the slots
                        self.spinSlots()
                        self.checkWinning()
                        self.gameOver()
                    }){
                        Image("spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                .layoutPriority(2)
                .disabled(coins <= 0)
                
                // FUNCTIONS
               
                // USER INFORMATION
                HStack{
                    //Your total Coins
                    HStack{
                        Text("Your\nCoins".uppercased())
                            .labelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
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
                    // Your Bet
                    HStack{
                        Text("\(betAmount)")
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
                            betAmount = 10
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
                        .disabled(coins < 10)
                        
                    }
                    
                    Spacer()
                    
                    HStack{
                        //Button - Bet 100
                        Button(action: {
                            print("You bet 100!")
                            betAmount = 100
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
                        .disabled(coins < 100)
                        
                        
                    }
                    
                }
                Spacer()
                Spacer()
                
            }
            
            // BUTTONS
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            //POP-UP
            if $showingModal.wrappedValue {
                ZStack{
                    Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)).edgesIgnoringSafeArea(.all)
                }
            }
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
