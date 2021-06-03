//
//  ContentView.swift
//  Bookworm
//
//  Created by Cao Mai on 6/2/21.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

    
    var body: some View {
            VStack {
                List {
                    ForEach(students, id: \.id) { student in
                        Text(student.name ?? "Unknown")
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
