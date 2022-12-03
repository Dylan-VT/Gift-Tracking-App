//
//  GiftIdeasModel.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import Foundation

//immutable struct
//default constructor takes an id
struct GiftIdeasModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    //overridden constructor assigns a random id
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    //changing GiftIdeaModel can only occur through this function
    func updateCompletion() -> GiftIdeasModel {
        return GiftIdeasModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}
