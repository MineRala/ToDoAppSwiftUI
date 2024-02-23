//
//  Alignments.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 23.02.2024.
//

import SwiftUI

extension HorizontalAlignment {
    private enum MyLeadingAlignment: AlignmentID {
        static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
            return dimensions[HorizontalAlignment.leading]
        }
    }
    static let myLeading = HorizontalAlignment(MyLeadingAlignment.self)
}
