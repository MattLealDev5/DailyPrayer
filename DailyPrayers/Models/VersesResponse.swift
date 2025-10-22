//
//  VerseResponse.swift
//  DailyPrayers
//
//  Created by Matthew Leal on 10/20/25.
//

import Foundation

struct VersesResponse: Codable {
    let verses: [Verse]
}

struct Verse: Codable, Identifiable {
    let book_id: String
    let book_name: String
    let chapter: Int
    let verse: Int
    let text: String

    var id: String { "\(book_name)-\(chapter):\(verse)" }
}
extension Verse {
    static var mocked: Verse {
        let jsonUrl = Bundle.main.url(forResource: "verse_mock", withExtension: "json")!
        let data = try! Data(contentsOf: jsonUrl)
        let versesResponse = try! JSONDecoder().decode(VersesResponse.self, from: data)
        return versesResponse.verses[0]
    }
}
