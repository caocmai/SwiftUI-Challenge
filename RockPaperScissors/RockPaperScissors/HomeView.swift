//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/20/21.
//

import SwiftUI

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
                ResultsView(userPick: $playerChoice, computerPick: $computerChoice, winner: $winner, scores: $scores)
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
