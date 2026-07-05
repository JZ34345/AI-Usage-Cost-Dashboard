//
//  Item.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/15/26.
//

import Foundation
import SwiftData

//Neglected, not used in app
@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
