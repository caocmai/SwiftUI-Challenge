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
    
//    var choices: [String] = ["rock", "paper", "scissors"]
//    @State private var computerIndex = Int.random(in: 0...2)
    @State private var computerChoice: String = ""
    
    @State private var winner: String = ""
    @State private var scores: Scores = Scores(playerScore: 0, computerScore: 0)
    
    let buttons: [GameOptions] = [.paper, .rock, .scissors]
    @State private var state = GameOptionState()
    
    var body: some View {
//            https://github.com/amelinagzz/CalculatorSwiftUIDemo/blob/main/betterCalculator/ContentView.swift
            ForEach(buttons, id: \.self) { button in
                    ActionView(button: button, currentState: $state)
                        .padding()
    
                
            }
            
            .sheet(isPresented: $state.showView) {
                ResultsView(userPick: $state.userChoice, computerPick: $state.computerChoice, winner: $state.winner, scores: $state.scores)
            }
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


struct ActionView: View {
    let button: GameOptions
    @Binding var currentState: GameOptionState
    
    var body: some View {
        Button(action: {
            self.tapped()
        }, label: {
            Image(button.rawValue)
        })
    }
    
    func tapped(){
        currentState.storedAction = button
        currentState.userChoice = button.rawValue
        currentState.winner = checkWinner()
        currentState.showView.toggle()
    }
    
    func checkWinner() -> WhoWins {
        let choices: [GameOptions] = [.rock, .paper, .scissors]
        let computerIndex = Int.random(in: 0...2)
        let computerChoice = choices[computerIndex].rawValue
        
        currentState.computerChoice = computerChoice
        
        if button.rawValue == computerChoice {
            return WhoWins.Tie
        }
        
        if (button.rawValue == GameOptions.rock.rawValue && computerChoice == GameOptions.scissors.rawValue) || (button.rawValue == GameOptions.paper.rawValue && computerChoice == GameOptions.rock.rawValue) || (button.rawValue == GameOptions.scissors.rawValue && computerChoice == GameOptions.paper.rawValue){
            currentState.scores.playerScore += 1
            return WhoWins.Player
        }
        currentState.scores.computerScore += 1
        return WhoWins.Computer
    }
    
    
}

struct GameOptionState {
    var storedAction: GameOptions!
    var showView: Bool = false
    var winner: WhoWins!
    var userChoice: String?
    var computerChoice: String?
    var scores: Scores = Scores(playerScore: 0, computerScore: 0)
}

enum GameOptions: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
    
}

