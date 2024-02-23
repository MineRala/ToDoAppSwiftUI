//
//  PriorityButtonView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 21.02.2024.
//

import SwiftUI

struct PriorityView: View {
    @Binding var priority: PriorityType
    @State var isSelectHigh: Bool
    @State var isSelectNormal: Bool
    @State var isSelectLow: Bool
    
    var body: some View {
        HStack {
            Spacer()
            PriorityButtonView(priority: .high, isSelect: $isSelectHigh) {
                isSelectNormal = false
                isSelectLow = false
                priority = .high
            }
            PriorityButtonView(priority: .normal, isSelect: $isSelectNormal) {
                isSelectHigh = false
                isSelectLow = false
                priority = .normal
            }
            PriorityButtonView(priority: .low, isSelect: $isSelectLow) {
                isSelectHigh = false
                isSelectNormal = false
                priority = .low
            }
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    PriorityView(priority: .constant(.normal), isSelectHigh: false, isSelectNormal: false, isSelectLow: false)
}
