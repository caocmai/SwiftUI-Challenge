//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/20/21.
//

import SwiftUI

struct SheetView: View {
    @Binding var userPick: String
    var choices: [String] = ["rock", "paper", "scissors"]
    
    @State var computerChoice = Int.random(in: 0...2)
    @State private var showingResult = true

    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack() {
            Text("Your Choice")
                .font(.title)
            Image(userPick+"-highlighted")
            
            Text("VS")
                .font(.title)
            Image(choices[computerChoice])
            
            
            
            Button("Press to dismiss") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.black)
        }
        .alert(isPresented: $showingResult, content: {
            Alert(title: Text("Winner is \(checkWinner())"), dismissButton: .default(Text("End")))
        })
    }
    
    func checkWinner() -> String{
        let computerPick = choices[computerChoice]
        if userPick == computerPick {
            return "Tie"
        }
        if (userPick == "rock" && computerPick == "scissors") || (userPick == "paper" && computerPick == "rock") || (userPick == "scissors" && computerPick == "paper"){
            return "You"
        }
        return "Computer"
    }
    
    
}


struct ContentView: View {
    
    @State private var showingSheet = false
    @State private var userChoice: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                print("Rock Tapped")
                showingSheet.toggle()
                userChoice = "rock"
            } label: {
                Image("rock")
            }
            Button {
                print("Paper Tapped")
                showingSheet.toggle()
                userChoice = "paper"
            } label: {
                Image("paper")
            }
            Button {
                print("Scissors tapped!")
                showingSheet.toggle()
                userChoice = "scissors"
            } label: {
                Image("scissors")
            }
            
            .sheet(isPresented: $showingSheet) {
                SheetView(userPick: $userChoice)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
