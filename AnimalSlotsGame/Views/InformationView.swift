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
        //MARK: Start of VSTACK (1)
        VStack(alignment: .center, spacing: 10){
            LogoView()
                .padding()
            
            Spacer()
            //MARK: How to play
            Form {
                Section(header: Text("How to Play?")){
                    HStack{
                        Text("Step 1:").foregroundColor(Color.gray)
                        Spacer()
                        Text("Pick bet amount of $10 or $100")
                    }
                    
                    HStack{
                        Text("Step 2:").foregroundColor(Color.gray)
                        Spacer()
                        Text("Press Spin Button")
                    }
                    
                    HStack{
                        Text("Step 3:").foregroundColor(Color.gray)
                        Spacer()
                        Text("Repeat")
                    }
                }
                
                //MARK: Winnings
                Section(header: Text("Winnings")){
                    
                    HStack{
                        Image("racoon").resizable().frame(width: 40, height: 40)
                        Image("racoon").resizable().frame(width: 40, height: 40)
                        Image("racoon").resizable().frame(width: 40, height: 40)
                        Text("Bet Amount x 5")
                    }
                    
                    HStack{
                        Image("monkey").resizable().frame(width: 40, height: 40)
                        Image("monkey").resizable().frame(width: 40, height: 40)
                        Image("monkey").resizable().frame(width: 40, height: 40)
                        Text("Bet Amount x 7")
                    }
                    
                    HStack{
                        Image("sloth").resizable().frame(width: 40, height: 40)
                        Image("sloth").resizable().frame(width: 40, height: 40)
                        Image("sloth").resizable().frame(width: 40, height: 40)
                        Text("Bet Amount x 10")
                    }
                    
                    HStack{
                        Image("lion").resizable().frame(width: 40, height: 40)
                        Image("lion").resizable().frame(width: 40, height: 40)
                        Image("lion").resizable().frame(width: 40, height: 40)
                        Text("Bet Amount x 14")
                    }
                    
                    HStack{
                        Image("seven").resizable().frame(width: 40, height: 40)
                        Image("seven").resizable().frame(width: 40, height: 40)
                        Image("seven").resizable().frame(width: 40, height: 40)
                        Text("Jackpot")
                    }
                    
                    
                }
            }
            .font(.system(.body,design: .rounded))
            
            
        }
        //MARK: End of VSTACK (1)
        .background(Color.white)
        
    }
    
    
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
