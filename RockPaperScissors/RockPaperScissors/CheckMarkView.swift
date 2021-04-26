//
//  CheckMarkView.swift
//  RockPaperScissors
//
//  Created by Cao Mai on 4/25/21.
//

import SwiftUI

struct CheckMarkView: View {
    
    var imageName: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack(spacing: 1) {
            Spacer()
            VStack {
                Image(systemName: "\(imageName).circle")
                    .font(.system(size: 60.0))
                    .foregroundColor(color)
                Text(text)
            }
            
        }
        
    }
}
