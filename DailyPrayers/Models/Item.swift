//
//  Item.swift
//  DailyPrayers
//
//  Created by Matthew Leal on 10/12/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var book_id: String
    var book_name: String
    var chapter: Int
    var verse: Int
    var text: String
    
    init(timestamp: Date, verse: Verse) {
        self.timestamp = timestamp
        self.book_id = verse.id
        self.book_name = verse.book_name
        self.chapter = verse.chapter
        self.verse = verse.verse
        self.text = verse.text
    }
}
