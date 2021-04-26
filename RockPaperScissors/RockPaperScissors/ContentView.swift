//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/20/21.
//

import SwiftUI

struct SmallView: View {
    
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

struct SheetView: View {
    @Binding var userPick: String
    @Binding var computerPick: String
    @Binding var winner: String
//    var choices: [String] = ["rock", "paper", "scissors"]
//
//    @State var computerChoice = Int.random(in: 0...2)
    @State private var showingResult = true
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack() {
            
            Text("Your Choice")
                .font(.title)
            ZStack {
                Image(userPick+"-highlighted")
                if winner == "Computer" {
                    SmallView()

                }
            }
            
            Text("VS")
                .font(.title)
            Image(computerPick)
            Button("Press to dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.black)
        }
//        .alert(isPresented: $showingResult, content: {
//            Alert(title: Text("Winner is \(checkWinner())"), dismissButton: .default(Text("End")))
//        })
    }
    

//    func checkWinner() -> String{
//
//        let computerPick = choices[computerChoice]
//        if userPick == computerPick {
//            return "Tie"
//        }
//        if (userPick == "rock" && computerPick == "scissors") || (userPick == "paper" && computerPick == "rock") || (userPick == "scissors" && computerPick == "paper"){
//            return "You"
//        }
//        return "Computer"
//    }
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
                print("Rock Tapped")
                showingSheet.toggle()
                userChoice = "rock"
                winner = checkWinner().rawValue
            } label: {
                Image("rock")
            }
            Button {
                print("Paper Tapped")
                showingSheet.toggle()
                userChoice = "paper"
                winner = checkWinner().rawValue
            } label: {
                Image("paper")
            }
            Button {
                print("Scissors tapped!")
                showingSheet.toggle()
                userChoice = "scissors"
                winner = checkWinner().rawValue
            } label: {
                Image("scissors")
            }
            
            .sheet(isPresented: $showingSheet) {
                
                SheetView(userPick: $userChoice, computerPick: $computerChoice, winner: $winner)
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
