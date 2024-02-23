//
//  SortView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 22.02.2024.
//

import SwiftUI

struct SortView: View {
    @Binding var selectedSortOption: SortType
    public let sortOptions: [SortType]
    public var didSelectOption: (SortType) -> Void
    @State private var shouldDismiss = false
    
    var body: some View {
        VStack {
            ForEach(sortOptions, id: \.self) { option in
                Button(action: {
                    didSelectOption(option)
                    shouldDismiss = true
                }) {
                    HStack {
                        Text(option.title)
                        Spacer()
                        if selectedSortOption == option {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                }
                .foregroundColor(selectedSortOption == option ? .blue : .black)
            }
        }
        .onChange(of: shouldDismiss) {
            if shouldDismiss {
                withAnimation {}
        }
        }
    }
}

// MARK: - Preview
#Preview {
    SortView(selectedSortOption: .constant(SortType.date), sortOptions: [SortType.priority, SortType.date], didSelectOption: { _ in
        
    })
}
