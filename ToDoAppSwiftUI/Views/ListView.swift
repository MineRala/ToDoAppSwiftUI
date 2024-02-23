//
//  ListView.swift
//  ToDoAppSwiftUI
//
//  Created by Mine Rala on 9.02.2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var context
    @Query private var items: [ItemModel]
    @State private var showingSheet = false
    @State private var isActive: Bool = false
    @State private var showingAlert = false
    @State private var deleteItemIndex = 0
    @State var selectedItem: ItemModel?
    @State private var searchText = ""
    @State private var selectedSortOption: SortType = .priority
    @State private var isSortOptionsVisible = false
    @State var filteredItems: [ItemModel]  = []
    @State private var isCompletedTapped = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if items.isEmpty {
                    NoItemsView(delegate: self)
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    VStack {
                        SearchBarView(text: $searchText)
                            .onChange(of: searchText) { oldValue, newValue in
                                updateList()
                            }
                        List {
                            ForEach(filteredItems) { item in
                                ListRowView(item: item, delegate: self)
                                    .onTapGesture {
                                        self.selectedItem = item
                                    }
                            }
                            .onDelete { indexSet in
                                if let firstIndex = indexSet.first {
                                    deleteItemIndex = firstIndex
                                }
                                showingAlert.toggle()
                            }
                        }
                        .onAppear {
                            updateList()
                        }
                        // cell tıklanıp item setlenmeden önce sheet yapılıyor sayfa açılması için o yüzden selectedItem göderiyorum sheet ederken
                        .sheet(item: $selectedItem) { item in
                            AddView(itemModel: item, delegate: self)
                        }
                        .listStyle(PlainListStyle())
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Delete Item"),
                                  message: Text("Are you sure you want to delete this item?"),
                                  primaryButton: .destructive(Text("Delete")) {
                                deleteItem()
                            },
                                  secondaryButton: .cancel(Text("Cancel")))
                        }
                    }
                }
            }
            .navigationBarTitle("TODO LIST", displayMode: .large)
            .navigationBarItems(leading: Button(action: {
                isCompletedTapped.toggle()
                updateList()
            }, label: {
                Text("Completed Items")
                    .foregroundColor(isCompletedTapped ? .darkGreenColor : .secondaryAccentColor)
                    .font(.headline)
            })
                                
                                , trailing:
                                    HStack {
                Button(action: {
                    isSortOptionsVisible.toggle()
                }) {
                    Text("Sort")
                        .foregroundColor(.secondaryAccentColor)
                        .font(.headline)
                }
                Button(action: {
                    showingSheet.toggle()
                }) {
                    Text("Add")
                        .foregroundColor(Color.secondaryAccentColor)
                        .font(.headline)
                }
                .disabled(isSortOptionsVisible)
            }
            )
            .sheet(isPresented: $showingSheet) {
                AddView(itemModel: selectedItem, delegate: self)
            }
            .overlay(
                VStack {
                    Spacer()
                    withAnimation {
                        SortView(selectedSortOption: $selectedSortOption, sortOptions: [SortType.priority, SortType.date], didSelectOption: { option in
                            selectedSortOption = option
                            isSortOptionsVisible.toggle()
                            updateList()
                        } )
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                        .offset(y: isSortOptionsVisible ? 0 : UIScreen.main.bounds.height)
                    }
                    Rectangle()
                        .frame(width: 0, height: 30)
                        .background(.white)
                }
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    .edgesIgnoringSafeArea(.bottom)
                    .background(
                        Color.black.opacity(isSortOptionsVisible ? 0.2 : 0)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {}
                    )
            )
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
        .onChange(of: items) { oldValue, newValue in
            updateList()
        }
    }
    
    private func deleteItem() {
        let model = filteredItems[deleteItemIndex]
        context.delete(model)
        try? context.save()
    }
    
    private func updateList() {
        let filteredByCompletion = items.filter { isCompletedTapped ? $0.isCompleted : !$0.isCompleted }
        let filteredBySearchText = searchText.isEmpty ? filteredByCompletion :
        filteredByCompletion.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.priority.rawValue == searchText
        }
        filteredItems = sortedItems(filteredBySearchText)
    }

    private func sortedItems(_ items: [ItemModel]) -> [ItemModel] {
        switch selectedSortOption {
        case .priority:
            return items.sorted { $0.priority.number >  $1.priority.number }
        case .date:
            return items.sorted(by: { $0.timestamp > $1.timestamp })
        }
    }
}

// MARK: - AddViewDelegate
extension ListView: AddViewDelegate {
    func sendModel(model: ItemModel, mode: ItemMode) {
        if mode == .add {
            context.insert(model)
        } else {
            try? context.save()
        }
    }
}

// MARK: - ListRowViewDelegate
extension ListView: ListRowViewDelegate {
    func saveUpdatingItem() {
        try? context.save()
        updateList()
    }
}

// MARK: - NoItemViewDelegate
extension ListView: NoItemViewDelegate {
    func addButtonTapped() {
        showingSheet.toggle()
    }
}

// MARK: - Preview
#Preview {
    ListView()
}
