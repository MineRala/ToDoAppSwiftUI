//
//  Enums.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 13.02.2024.
//

import SwiftUI

public enum ItemMode {
    case add
    case edit
    
    var title: String  {
        switch self {
        case .add:
            return "Add A New Item"
        case .edit:
            return "Update A Item"
        }
    }
    
    var buttonText: String  {
        switch self {
        case .add:
            return "Add"
        case .edit:
            return "Save"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .add:
            return Color.secondaryAccentColor
        case .edit:
            return Color.accentColor
        }
    }
}

public enum PriorityType: String, Codable, Equatable {
    case unkown = ""
    case high = "High"
    case normal = "Normal"
    case low = "Low"

    var number: Int {
        switch self {
        case .unkown:
            return 0
        case .high:
            return 3
        case .normal:
            return 2
        case .low:
            return 1
        }
        
    }

    var backgroundColor: Color {
        switch self {
        case .high:
            return Color.red
        case .normal:
            return Color.orange
        case .low:
            return Color.green
        case .unkown:
            return Color.gray.opacity(0.5)
        }
    }
}

public enum SortType {
    case priority
    case date
    
    var title: String {
        switch self {
        case .priority:
            "By Priority"
        case .date:
            "By Date"
        }
    }
}
