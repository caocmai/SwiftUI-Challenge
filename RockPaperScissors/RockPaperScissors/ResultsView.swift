//
//  ResultsView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/25/21.
//

import SwiftUI

struct ResultsView: View {
    @Binding var userPick: String
    @Binding var computerPick: String
    @Binding var winner: String
    @Binding var scores: Scores
    
    @State private var showingResult = true
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack() {
            VStack(alignment: .trailing) {
                // move this to the upper right hand side?
                // add animations?
                // to animation text look at
                // https://www.hackingwithswift.com/quick-start/swiftui/how-to-animate-the-size-of-text
                Text("Player: \(scores.playerScore) ")
                    .font(.title)
                Text("Computer: \(scores.computerScore) ")
                    .font(.title)
                    .scaleEffect(1)
                    .animation(Animation.interpolatingSpring(stiffness: 50, damping: 1)
                                .delay(2).repeatForever()
                    )

                    

            }
            Text("Your Choice")
            
            ZStack {
                Image(userPick+"-highlighted")
                if winner == WhoWins.Player.rawValue {
                    CheckMarkView(imageName: "checkmark", text: "Winner", color: Color.green) // change the contraint of this? move it away from the edge
                }
            }
            
            ZStack {
                Text("VS")
                    .font(.title)
                if winner == WhoWins.Tie.rawValue {
                    CheckMarkView(imageName: "equal", text: "Tie", color: Color.yellow)
                }
            }
            
            ZStack {
                Image(computerPick)
                if winner == WhoWins.Computer.rawValue {
                    CheckMarkView(imageName: "checkmark", text: "Winner", color: Color.green)
                }
            }
            
            // how to seperate this out?
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(Color.orange)
            .cornerRadius(9)
        }
//        .alert(isPresented: $showingResult, content: {
//            Alert(title: Text("\(winner) wins!"), message: Text("Player Score: \(scores.playerScore) \n Computer Score: \(scores.computerScore)"), dismissButton: .default(Text("End")))
//        })
    }
    
}
