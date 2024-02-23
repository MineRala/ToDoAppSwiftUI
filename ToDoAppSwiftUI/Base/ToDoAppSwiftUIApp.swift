//
//  ToDoAppSwiftUIApp.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import SwiftUI
import SwiftData

@main
struct ToDoAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
        }
        .modelContainer(for: ItemModel.self)
    }
}
