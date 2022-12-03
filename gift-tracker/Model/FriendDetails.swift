//
//  FriendDetails.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import SwiftUI
import Foundation
import Combine

/*
FriendDetails is 'UserDefaults' data that contains a boolean of whether or not
 the user needs to get the friend a gift, and a list of strings that are gift ideas
 */
class FriendDetails: ObservableObject  {
    //@Published var unique_id: UUID
    @Published var userID: String
    @Published var giftIdeas: [String]? {
        didSet {
            UserDefaults.standard.set(giftIdeas, forKey: "gift_ideas")
        }
    }
    
    init(id: String) {
        //unique_id = UUID()
        self.userID = id
        self.giftIdeas = UserDefaults.standard.object(forKey: "gift_ideas") as? [String] ?? [""]
    }
}

//class FriendDetails: ObservableObject {
//    @Published var userID: String
//    @Published var needGift: Bool {
//        didSet {
//            UserDefaults.standard.set(needGift, forKey: "\(userID)_need_gift")
//        }
//    }
//    @Published var giftIdea: String {
//        didSet {
//            UserDefaults.standard.set(giftIdea, forKey: "\(userID)_gift_idea")
//        }
//    }
//    init(id: String) {
//        self.userID = id
//        self.needGift = UserDefaults.standard.object(forKey: "\(userID)_need_gift") as? Bool ?? false
//        self.giftIdea = UserDefaults.standard.object(forKey: "\(userID)_gift_idea") as? String ?? ""
//    }
//}
