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
    
    let images = ["sloth","monkey","lion", "racoon","seven"]
    
    
    
    // Creating variables
    @State private var jackpot: Int = 25000
    @State private var coins: Int = 2500
    @State private var betAmount: Int = 10
    @State private var amountOne: Int = 0
    @State private var numberOfTries = 0
    @State private var highscore = 0
    
    @State private var showingModal: Bool = false
    @State private var showingWinAmount: Bool = false
    @State private var showingJackpotAmount: Bool = false
    @State private var showingAlert: Bool = false
    @State private var disabledBtn: Bool = false
    @State private var showingInfoView: Bool = false
    
    
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
        var rndImages = images.shuffled().shuffled().shuffled()
        slots = slots.map({ _ in
            Int.random(in: 0...images.count - 1)
        })
        let hasAllItemsEqual = slots.dropFirst().allSatisfy({ $0 == slots.first})
        
        if hasAllItemsEqual == true && numberOfTries < 10{
            rndImages = images.shuffled().shuffled()
            slots = slots.map({ _ in
                Int.random(in: 0...rndImages.count - 1)
            })
            
        }
    }
    
    // Check To See if the player won
    func checkWinning(){
        
        let hasAllItemsEqual = slots.dropFirst().allSatisfy({$0 == slots.first})
        if hasAllItemsEqual {
            let index = slots[0]
            print(index)
            //MARK: JACKPOT PAY OUT
            if images[index] == "seven"{
                //Jackpot Won
                showingJackpotAmount = true
                coins += jackpot
            }
            
            //MARK: SLOTH PAY OUT
            if images[index] == "sloth"{
                showingWinAmount = true
                coins += betAmount * 10
                amountOne = betAmount * 10
                
            }
            
            //MARK: MONKEY PAY OUT
            if images[index] == "monkey"{
                showingWinAmount = true
                coins += betAmount * 7
                amountOne = betAmount * 7
            }
            
            
            //MARK: LION PAY OUT
            if images[index] == "lion"{
                coins += betAmount * 14
                amountOne = betAmount * 14
                showingWinAmount = true
            }
            
            //MARK: RACOON PAY OUT
            if images[index] == "racoon"{
                coins += betAmount * 5
                amountOne = betAmount * 5
                showingWinAmount = true
            }
            
            numberOfTries = 0
            //self.playerWins()
        }else{
            numberOfTries = numberOfTries + 1
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
    
    // MARK: Bet Checker
    func checkBetAmount(){
        if betAmount == 100{
            if coins < betAmount{
                betAmount = 10
            }
        }
    }
    
    //MARK: Game Over Popup
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
                
                
                
                //MARK: JACKPOT LABELS
                HStack{
                    Text("JACKPOT".uppercased())
                        .numberStyle()

                        .multilineTextAlignment(.trailing)
                    
                    Text("\(jackpot)")
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
                
                //MARK: SLOTS Handlers
                VStack(alignment: .center, spacing: 0){
                    
                    // MARK: Slot 1
                    ZStack{
                        SlotsView()
                        Image(images[slots[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            
                    }
                    
                    HStack(alignment: .center, spacing: 0){
                        // MARK: SLot 2
                        ZStack{
                            SlotsView()
                            Image(images[slots[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                        Spacer()
                        // MARK: SLot 3
                        ZStack{
                            SlotsView()
                            Image(images[slots[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                
                        }
                        
                    }
                    
                    //MARK: Spin Button
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
            
               
                //MARK: USER INFORMATION
                HStack{
                    //MARK: Your total Coins Label
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
                    // MARK: Your Bet Label
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
                        //MARK: Button - Bet 10
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
                        .blur(radius: coins < 10 ? 3 : 0, opaque: false)
                        .disabled(coins < 10) //coin count below 10, disable the button
                        
                    }
                    
                    Spacer()
                    
                    HStack{
                        //MARK: Button - Bet 100
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
                        .blur(radius: coins < 100 ? 3 : 0, opaque: false)
                        .disabled(coins < 100) // coin count below 100, disable the button
                    }
                    
                }
                Spacer()
                
                HStack{
                    
                    HStack{
                        //MARK: HIGHSCORE
                        Button(action: {
                            
                        }){
                            Text("HIGH\nSCORE")
                                .highStyle()
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
                        .blur(radius: coins < 10 ? 3 : 0, opaque: false)
                        .disabled(coins < 10) //coin count below 10, disable the button
                        
                    }
                }
            }
            
            
            // BUTTONS
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            .blur(radius: $showingWinAmount.wrappedValue ? 5 : 0, opaque: false)
            .blur(radius: $showingJackpotAmount.wrappedValue ? 5 : 0, opaque: false)
            .blur(radius: $showingAlert.wrappedValue ? 5 : 0, opaque: false)
            
            //MARK: POP-UP for Game Over
            if $showingModal.wrappedValue {
                ZStack{
                    
                    
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
            
            //MARK: POP-UP for Jackpot Win
            if $showingJackpotAmount.wrappedValue {
                ZStack{
                    
                    
                    //Title - Game Over
                    VStack(spacing: 0){
                        Text("!!JACKPOT!!")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("informationBg"))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    //Message
                        VStack(alignment: .center, spacing: 16){
                            Text("You Won The JACKPOT amount of\n $\(jackpot)")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                        }
                        
                        Spacer()
                        
                        //Button - Restart the game
                        Button(action:{
                            self.showingJackpotAmount = false
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
            
            //MARK: POP-UP for ALERT
            
            if $showingAlert.wrappedValue {
                ZStack{
                    
                    
                    //Title - Game Over
                    VStack(spacing: 0){
                        Text("Animal Slots")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("informationBg"))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    //Message
                        VStack(alignment: .center, spacing: 16){
                            Text("Please Choose If you would like to:")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                        }
                        
                        Spacer()
                        
                        //MARK: ALERT RESTART
                        Button(action:{
                            self.showingAlert = false
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
                        
                        //MARK: ALERT QUIT
                        Button(action:{
                            self.showingAlert = false
                            exit(0)
                        }){
                            Text("QUIT")
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
                        
                        //MARK: ALERT CANCEL
                        Button(action:{
                            self.showingAlert = false
                        }){
                            Text("CANCEL")
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
        .overlay(
            Button(action: {
                showingAlert = true
            }){
                Image(systemName: "arrow.2.circlepath.circle")
            }
            .font(.title)
            .accentColor(Color.white),
            alignment: .topLeading
        
        )
        .overlay(
            Button(action: {
                self.showingInfoView = true
            }){
                Image(systemName: "info.circle")
            }
            .font(.title)
            .accentColor(Color.white),
            alignment: .topTrailing
        )
        .padding()
        .frame(maxWidth: 720)
        
        .sheet(isPresented: $showingInfoView){
            InformationView()
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
