//
//  GiftIdeasViewModel.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import Foundation

class GiftIdeasViewModel: ObservableObject {
    
    @Published var items: [GiftIdeasModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            GiftIdeasModel(title: "First idea!", isCompleted: false),
            GiftIdeasModel(title: "Second idea!", isCompleted: true),
            GiftIdeasModel(title: "Third idea!", isCompleted: false)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = GiftIdeasModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: GiftIdeasModel) {
        if let i = items.firstIndex(where: { $0.id == item.id }) {
            //update item (keep same id)
            items[i] = item.updateCompletion()
        }
    }
}
