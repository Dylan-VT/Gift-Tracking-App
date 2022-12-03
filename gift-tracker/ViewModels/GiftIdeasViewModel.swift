//
//  GiftIdeasViewModel.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import Foundation

class GiftIdeasViewModel: ObservableObject {
    
    @Published var items: [GiftIdeasModel] = [] {
        //computed property - anytime items changes, didSet is called
        didSet {
            saveItems()
        }
    }
    
    //TODO: Add for every user
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        //dummy data - can delete
//        let newItems = [
//            GiftIdeasModel(title: "First idea!", isCompleted: false),
//            GiftIdeasModel(title: "Second idea!", isCompleted: true),
//            GiftIdeasModel(title: "Third idea!", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
        
        //need to unwrap optional - use guard
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([GiftIdeasModel].self, from: data)
        else { return }
        
        //update items array with saved data
        self.items = savedItems
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
    
    /*
    UserDefaults can't read or save GiftIdeasModel, so we need to write to
    and read from JSON
    */
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            //encode
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
