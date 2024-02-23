//
//  ListRowView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import SwiftUI

private struct Constant {
    static let paddingValue = 4
}

protocol ListRowViewDelegate {
    func saveUpdatingItem()
}

struct ListRowView: View {
    @State private var showingSheet = false
    let item: ItemModel
    var delegate: ListRowViewDelegate?
    
    var body: some View {
        let isCompleted = item.isCompleted
        VStack(alignment: .myLeading) {
            HStack {
                Image(systemName: isCompleted ? "checkmark.circle" : "circle")
                    .resizable()
                    .frame(width: 16, height: 16, alignment: .center)
                    .foregroundColor(isCompleted ? .green : .red)
                    .padding(.leading, Constant.paddingValue.toCGFloat)
                    .onTapGesture {
                        updateItemCompleteState(item: item)
                    }
                Text(item.title)
                    .foregroundColor(.black)
                    .frame(minHeight: 50, alignment: .center)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .alignmentGuide(.myLeading) { $0[.leading] }
                Spacer()
                Circle()
                    .foregroundColor(item.priority.backgroundColor)
                    .frame(width: 12, height: 12)
                    .padding(.trailing, 12)
            }
            Text("\(item.timestamp, formatter: DateFormatter.dateFormatter)")
                .foregroundColor(.black)
                .font(.subheadline)
                .fontWeight(.light)
                .padding(.bottom, 4)
                .alignmentGuide(.myLeading) { $0[.leading] }
        }
        .listRowSeparator(.hidden)
        .padding(.all, Constant.paddingValue.toCGFloat)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 2)
    }
    
    private func updateItemCompleteState(item: ItemModel) {
        self.item.isCompleted = !item.isCompleted
        delegate?.saveUpdatingItem()
    }
}

// MARK: - Preview
struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyItems: [ItemModel] = [
            ItemModel(title: "Item 1", isCompleted: false, timeStamp: Date(), priority: .unkown),
            ItemModel(title: "Item 2", isCompleted: true, timeStamp: Date(), priority: .unkown),
            ItemModel(title: "Item 3", isCompleted: false, timeStamp: Date(), priority: .unkown)
        ]
        Group {
            ForEach(dummyItems) { item in
                ListRowView(item: item)
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
