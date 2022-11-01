//
//  User.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/31/22.
//

import Foundation
import SwiftUI

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var user_name: String
    var display_name: String
    var birthday: Date

    private var user_profile_picture: String
    var image: Image {
        Image(user_profile_picture)
    }
}
