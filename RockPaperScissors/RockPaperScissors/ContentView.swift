//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/20/21.
//

import SwiftUI

struct ContentView: View {
    
    
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                print("Rock Tapped")
            } label: {
                Image("rock")
            }
            Button {
                print("Paper Tapped")
            } label: {
                Image("paper")
            }
            Button {
                print("Scissors tapped!")
            } label: {
                Image("scissors")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
