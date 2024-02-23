//
//  AddView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import SwiftUI

private struct Constant {
    static let paddingValue = 10
}

protocol AddViewDelegate {
    func sendModel(model: ItemModel, mode: ItemMode)
}

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State private var textFieldText: String = ""
    @State private var isSaveEnabled = false
    @State var priorityType: PriorityType = .unkown

    private let width = (UIScreen.main.bounds.width - 20) / 2
    private var itemMode: ItemMode
    private var item: ItemModel?
    private var delegate: AddViewDelegate?
    
    init(itemModel: ItemModel? = nil, delegate: AddViewDelegate? = nil) {
        if let itemModel {
            item = itemModel
            itemMode = .edit
        } else {
            itemMode = .add
        }
        self.delegate = delegate
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(itemMode.title)
                    .foregroundColor(Color.black)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(height: 32)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(Color.black)
                        .font(.title3)
                }
            }
            Rectangle()
                .frame(width: 0, height: 12)
            TextField("Type the item name", text: $textFieldText)
                .onAppear {
                    if let item {
                        textFieldText = item.title
                    }
                }
                .padding(.all, Constant.paddingValue.toCGFloat)
                .frame(height: 50)
                .cornerRadius(10)
                .accentColor(.black)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(itemMode == .add ? Color.secondaryAccentColor.opacity(0.5) : Color.accentColor.opacity(0.5) , lineWidth: 2)
                )
                .onChange(of: textFieldText) { _, newValue in
                    updateSaveButtonState()
                }
            Rectangle()
                .frame(width: 0, height: 12)
            Label {
                Text("Priority")
                    .font(.system(size: 20))
            } icon: {
                
            }
            PriorityView(priority: $priorityType, isSelectHigh: item?.priority == .high, isSelectNormal: item?.priority == .normal, isSelectLow: item?.priority == .low)
            Rectangle()
                .frame(width: 0, height: 8)
            HStack {
                Spacer()
                Button(action: saveButtonTapped, label: {
                    Text(itemMode.buttonText.uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(width: self.width, height: 50)
                        .background(itemMode.backgroundColor)
                        .cornerRadius(10)
                })
                .disabled(!isSaveEnabled)
                Spacer()
            }
            Spacer()
        }
        .padding(30)
        .onChange(of: priorityType) { oldValue, newValue in
            updateSaveButtonState()
        }
    }
    
    private func updateSaveButtonState() {
        isSaveEnabled = !textFieldText.isEmpty && (item?.title != textFieldText || item?.priority != priorityType) && priorityType != .unkown
    }
    
    private func saveButtonTapped() {
        if itemMode == .add {
            let newItem = ItemModel(title: textFieldText, isCompleted: false, timeStamp: Date(), priority: priorityType)
            delegate?.sendModel(model: newItem, mode: .add)
        } else {
            self.item?.title = textFieldText
            self.item?.priority = priorityType
            if let item {
                delegate?.sendModel(model: item, mode: .edit)
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Previews
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(delegate: self as? AddViewDelegate)
            .previewLayout(.sizeThatFits)
    }
}
