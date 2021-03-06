//
//  ContentView.swift
//  Bookworm
//
//  Created by Cao Mai on 6/2/21.
//

import SwiftUI

struct BookListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)

            }
               .navigationBarTitle("Bookworm")

            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                   self.showingAddScreen.toggle()
               }) {
                   Image(systemName: "plus")
               })
               .sheet(isPresented: $showingAddScreen) {
                   AddBookView().environment(\.managedObjectContext, self.moc)
               }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // Find book in fetch request
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
