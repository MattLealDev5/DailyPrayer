//
//  TestView.swift
//  DailyPrayers
//
//  Created by Matthew Leal on 10/18/25.
//

import Foundation
import SwiftUI

struct TestView: View {
    
    @State var loading: Bool = false
    @State var done: Bool = false
    @State var planetName = "no name found"
    let testURL = "http://swapi.dev/api/planets/1/"
    
    var body: some View {
        ZStack {
            if (!loading) {
                Text(planetName)
            } else {
                Text("uhhhhhh...")
            }
        }
        .onAppear() {
            action()
        }
    }
    
    func action() {
        self.loading = true
        self.done = false
        
        guard let url = URL(string: testURL) else {
            print("Fuck off")
            return
        }
        
        print("hello")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { print("Fuck off 2"); return }
            do {
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { print("Fuck off 3"); return }
                if (statusCode == 200) {
                    let finalData = try JSONDecoder().decode(StarWarsTest.self, from: data)
                    self.planetName = finalData.name
                    
                    self.loading = false
                    self.done = true
                }
            } catch {
                print(error)
                self.loading = false
            }
        }.resume()
    }
}

#Preview {
    TestView()
}
