//
//  ContentView.swift
//  DailyPrayers
//
//  Created by Matthew Leal on 10/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]

    var body: some View {
        PrayerView()
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
