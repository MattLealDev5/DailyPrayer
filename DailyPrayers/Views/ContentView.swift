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
    @State private var verse: Verse = Verse.mocked
    @State private var verseFetched = false

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(value: verse) {
                    Circle()
                        .padding()
                }
            }
            .onAppear(perform: {
                Task {
                    await fetchVerse()
                }
            })
            .navigationDestination(for: Verse.self) { verse in
                PrayerView(verseData: verse)
            }
//            .navigationDestination(for: Verse.self) { verse in
//                PrayerListView()
//            }
        }
    }
    
    private func fetchVerse() async {
        // URL for the API endpoint
        // 👋👋👋 Make sure to replace {YOUR_API_KEY} in the URL with your actual NPS API Key
        let url = URL(string: "https://bible-api.com/leviticus%2011:12")!
        do {

            // Perform an asynchronous data request
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decode json data into ParksResponse type
            let versesResponse = try JSONDecoder().decode(VersesResponse.self, from: data)

            // Get the array of parks from the response
            let verses = versesResponse.verses

            // Print the full name of each park in the array
            for verse in verses {
                print(verse.id)
            }

            // Set the parks state property
            self.verse = verses[0]
            self.verseFetched = true

        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
