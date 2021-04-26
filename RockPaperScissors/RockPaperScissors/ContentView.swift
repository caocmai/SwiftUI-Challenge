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
        //        .alert(isPresented: $showingResult, content: {
        //            Alert(title: Text("Winner is \(checkWinner())"), dismissButton: .default(Text("End")))
        //        })
    }
    
}


struct ContentView: View {
    
    @State private var showingSheet = false
    @State private var userChoice: String = ""
    
    var choices: [String] = ["rock", "paper", "scissors"]
    @State var computerIndex = Int.random(in: 0...2)
    @State private var computerChoice: String = ""
    
    @State private var winner: String = ""
    
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                showingSheet.toggle()
                userChoice = "rock"
                winner = checkWinner().rawValue
            } label: {
                Image("rock")
            }
            Button {
                showingSheet.toggle()
                userChoice = "paper"
                winner = checkWinner().rawValue
            } label: {
                Image("paper")
            }
            Button {
                showingSheet.toggle()
                userChoice = "scissors"
                winner = checkWinner().rawValue
            } label: {
                Image("scissors")
            }
            
            .sheet(isPresented: $showingSheet) {
                
                ResultView(userPick: $userChoice, computerPick: $computerChoice, winner: $winner)
            }
        }
    }
    
    func checkWinner() -> WhoWins{
        
        computerChoice = choices[computerIndex]
        if userChoice == computerChoice {
            return WhoWins.Tie
        }
        if (userChoice == "rock" && computerChoice == "scissors") || (userChoice == "paper" && computerChoice == "rock") || (userChoice == "scissors" && computerChoice == "paper"){
            return WhoWins.Player
        }
        return WhoWins.Computer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum WhoWins: String {
    case Player
    case Computer
    case Tie
}
