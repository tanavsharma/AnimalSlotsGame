//
//  ContentView.swift
//  AnimalSlotsGame
//
//  Created by Tanav Sharma on 2022-02-01.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Variable Declaration
    
    //Create Array to Hold all the slot images
    
    let images = ["sloth","sloth","monkey","lion","lion", "racoon","seven"]
    
    // Creating variables
    @State private var showingAlert = false
    @State private var coins: Int = 2500
    @State private var betAmount: Int = 10
    @State private var amountOne: Int = 0
    @State private var showingModal: Bool = false
    @State private var showingWinAmount: Bool = false
    @State private var disabledBtn: Bool = false
    
    
    /* Creating an array for each slot:
     * Index 0 = Slot On Top
     * Index 1 = Slot On Bottom Left
     * Index 2 = Slot On Bottom Right
     */
    @State private var slots: Array = [0,1,2]
    
    
    // MARK: Functions
    
    /* Functions which will handle the following:
     * Spin the slots
     * Check to see if the player won
     * Display message if player wins, and update coin count
     * End game if player loses all coins, or doesnt have enough funds
     */
    
    
    // MARK: Spin the slots
    func spinSlots(){
        slots = slots.map({ _ in
            Int.random(in: 0...images.count - 1)
        })
    }
    
    // Check To See if the player won
    func checkWinning(){
        if slots[0] == slots[1] && slots[1] == slots[2] && slots[0] == slots[2] {
            self.playerWins()
        }else{
            playerLoses()
        }
    }
    
    // MARK: Player Wins
    func playerWins(){
        coins += betAmount * 10
        amountOne = betAmount * 10
        showingWinAmount = true
    }
    
    // MARK: Player Loses
    func playerLoses(){
        coins -= betAmount
    }
    
    func checkBetAmount(){
        if betAmount == 100{
            if coins < betAmount{
                betAmount = 10
            }
        }
    }
    
    // Game Over Popup
    func gameOver(){
        if coins <= 0{
            showingModal = true
        }
    }
    
    
    
    var body: some View {
        ZStack{
            
            //MARK: MAIN USER INTERFACE
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
                        //Spin the slots
                        self.spinSlots()
                        self.checkWinning()
                        self.gameOver()
                        self.checkBetAmount()
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
                        .disabled(coins < 10) //coin count below 10, disable the button
                        
                    }
                    
                    Spacer()
                    
                    HStack{
                        //Button - Bet 100
                        Button(action: {
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
                        .disabled(coins < 100) // coin count below 100, disable the button
                    }
                    
                }
                Spacer()
                Spacer()
                
            }
            
            // BUTTONS
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            //MARK: POP-UP for Game Over
            if $showingModal.wrappedValue {
                ZStack{
                    Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)).edgesIgnoringSafeArea(.all)
                    
                    //Title - Game Over
                    VStack(spacing: 0){
                        Text("Game Over")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("informationBg"))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    //Message
                        VStack(alignment: .center, spacing: 16){
                            Text("Sorry! You are out of coins. \n Restart the game to continue playing.")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                        }
                        
                        Spacer()
                        
                        //Button - Restart the game
                        Button(action:{
                            self.showingModal = false
                            self.coins = 2500
                        }){
                            Text("RESTART")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .accentColor(Color("informationBg"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75)
                                        .foregroundColor(Color("informationBg"))
                                )
                            
                        }
                    
                        Spacer()
                        
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 200, idealHeight: 220, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                }
            }
            
            //MARK: POP-UP for Game Win
            if $showingWinAmount.wrappedValue {
                ZStack{
                    Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)).edgesIgnoringSafeArea(.all)
                    
                    //Title - Game Over
                    VStack(spacing: 0){
                        Text("Congratulations!")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("informationBg"))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    //Message
                        VStack(alignment: .center, spacing: 16){
                            Text("You Won $\(amountOne)")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                        }
                        
                        Spacer()
                        
                        //Button - Restart the game
                        Button(action:{
                            self.showingWinAmount = false
                        }){
                            Text("CONTINUE")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .accentColor(Color("informationBg"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .frame(minWidth: 128)
                                .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75)
                                        .foregroundColor(Color("informationBg"))
                                )
                            
                        }
                    
                        Spacer()
                        
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 200, idealHeight: 220, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
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
