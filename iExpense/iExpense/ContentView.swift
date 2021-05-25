//
//  ContentView.swift
//  iExpense
//
//  Created by Cao Mai on 5/24/21.
//

import SwiftUI

struct ExpenseItem: Identifiable { // protocol to make in identifiable with uuid
    let id = UUID() // to make each instance unique
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false


    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)

            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    self.expenses.items.append(expense)
                    self.showingAddExpense = true

                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                // show an AddView here
                AddView(expenses: self.expenses)

            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}
