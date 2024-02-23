//
//  DateFormatter.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 21.02.2024.
//

import Foundation

extension DateFormatter {
    public static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}
