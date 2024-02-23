//
//  Item.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import Foundation
import SwiftData

@Model
final class ItemModel: Identifiable{
    let id: String
    var title: String
    var isCompleted: Bool
    var timestamp: Date
    var priority: PriorityType

    init(title: String, isCompleted: Bool, timeStamp: Date, priority: PriorityType) {
        self.id = UUID().uuidString
        self.title = title
        self.isCompleted = isCompleted
        self.timestamp = timeStamp
        self.priority = priority
    }
}
