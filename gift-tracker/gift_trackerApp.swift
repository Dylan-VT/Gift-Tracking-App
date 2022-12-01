//
//  gift_trackerApp.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/20/22.
//

import SwiftUI
@main
struct gift_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            //need to add dateholder as environmental object to work.
            let dateHolder = DateHolder()
            ContentView()
                .environmentObject(dateHolder)
        }
    }
}


