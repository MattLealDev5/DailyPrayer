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
        PrayerView(verseData: Verse.mocked)
    }
    
//    private func fetchVerse() async {
//        // URL for the API endpoint
//        // 👋👋👋 Make sure to replace {YOUR_API_KEY} in the URL with your actual NPS API Key
//        let url = URL(string: "https://developer.nps.gov/api/v1/parks?stateCode=ca&api_key=Bey2ZExGkPUGcqwUmdS2Tas0vdV9FSn1uObcTjxh")!
//        do {
//
//            // Perform an asynchronous data request
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // Decode json data into ParksResponse type
//            let parksResponse = try JSONDecoder().decode(ParksResponse.self, from: data)
//
//            // Get the array of parks from the response
//            let parks = parksResponse.data
//
//            // Print the full name of each park in the array
//            for park in parks {
//                print(park.fullName)
//            }
//
//            // Set the parks state property
//            self.parks = parks
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
