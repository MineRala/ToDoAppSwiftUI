//
//  Item.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
