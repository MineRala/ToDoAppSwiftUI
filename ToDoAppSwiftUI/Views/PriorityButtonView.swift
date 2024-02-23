//
//  PriorityButtonView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

struct PriorityButtonView: View {
    var priority: PriorityType
    @Binding var isSelect: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            isSelect = true
            onTap()
        }) {
            Text(priority.rawValue)
                .foregroundColor(.white)
                .padding()
                .background(isSelect ? priority.backgroundColor : Color.gray.opacity(0.5))
                .cornerRadius(10)
        }
        .disabled(isSelect)
    }
}

#Preview {
    PriorityButtonView(priority: .high, isSelect: .constant(false), onTap: {})
}

// MARK: - Preview
#Preview {
    PriorityButtonView(priority: .high, isSelect: .constant(true), onTap: {})
}
