//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/20/21.
//

import SwiftUI

struct TieView: View {
    
    var body: some View {
        HStack(spacing: 1) {
            Spacer()
            VStack {
                Image(systemName: "equal.circle")
                    .font(.system(size: 60.0))
                    .foregroundColor(.yellow)
                Text("Tie")
            }
            
        }
        
    }
}

struct CheckMark: View {
    
    var body: some View {
        HStack(spacing: 1) {
            Spacer()
            VStack {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 60.0))
                    .foregroundColor(.green)
                Text("Winner")
            }
            
        }
        
    }
}

struct ResultView: View {
    @Binding var userPick: String
    @Binding var computerPick: String
    @Binding var winner: String
    @Binding var scores: Scores
    
    @State private var showingResult = true
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack() {
            Text("Your Choice")
                .font(.title)
            ZStack {
                Image(userPick+"-highlighted")
                if winner == WhoWins.Player.rawValue {
                    CheckMark() // change the contraint of this? move it away from the edge
                }
            }
            
            ZStack {
                Text("VS")
                    .font(.title)
                if winner == WhoWins.Tie.rawValue {
                    TieView()
                }
            }
            
            ZStack {
                Image(computerPick)
                if winner == WhoWins.Computer.rawValue {
                    CheckMark()
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
                .alert(isPresented: $showingResult, content: {
                    Alert(title: Text("\(winner) wins!"), message: Text("Player Score: \(scores.playerScore) \n Computer Score: \(scores.computerScore)"), dismissButton: .default(Text("End")))
                })
    }
    
}


struct HomeView: View {
    
    @State private var showingSheet = false
    @State private var playerChoice: String = ""
    
    var choices: [String] = ["rock", "paper", "scissors"]
    @State var computerIndex = Int.random(in: 0...2)
    @State private var computerChoice: String = ""
    
    @State private var winner: String = ""
    @State private var scores: Scores = Scores(playerScore: 0, computerScore: 0)
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                showingSheet.toggle()
                playerChoice = "rock"
                winner = checkWinner().rawValue
            } label: {
                Image("rock")
            }
            Button {
                showingSheet.toggle()
                playerChoice = "paper"
                winner = checkWinner().rawValue
            } label: {
                Image("paper")
            }
            Button {
                showingSheet.toggle()
                playerChoice = "scissors"
                winner = checkWinner().rawValue
            } label: {
                Image("scissors")
            }
            
            .sheet(isPresented: $showingSheet) {
                ResultView(userPick: $playerChoice, computerPick: $computerChoice, winner: $winner, scores: $scores)
            }
        }
    }
    
    func checkWinner() -> WhoWins {
        computerChoice = choices[computerIndex]
        if playerChoice == computerChoice {
            return WhoWins.Tie
        }
        if (playerChoice == "rock" && computerChoice == "scissors") || (playerChoice == "paper" && computerChoice == "rock") || (playerChoice == "scissors" && computerChoice == "paper"){
            scores.playerScore += 1
            return WhoWins.Player
        }
        scores.computerScore += 1
        return WhoWins.Computer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


enum WhoWins: String {
    case Player
    case Computer
    case Tie
}

struct Scores {
    var playerScore: Int
    var computerScore: Int
}
