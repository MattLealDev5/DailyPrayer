//
//  ContentView.swift
//  QuickChat
//
//  Created by Matthew Leal on 10/27/25.
//

import SwiftUI
import SwiftData

struct PrayerListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    Text("\(item.book_id)\n\(item.text)")
                        .padding()
                } label: {
                    Text("\(item.book_id) (\(item.timestamp, format: Date.FormatStyle(date: .numeric)))")
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date(), verse: Verse.mocked)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    NavigationStack {
        PrayerListView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
