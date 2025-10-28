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
    var verse: Verse
    
    init(timestamp: Date, verse: Verse) {
        self.timestamp = timestamp
        self.verse = verse
    }
}
