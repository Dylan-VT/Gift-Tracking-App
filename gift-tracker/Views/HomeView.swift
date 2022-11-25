//
//  HomeView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/20/22.
//

import SwiftUI

let dummyFriends: [UserAccount]  = [UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25"), UserAccount(birthday: "2001-10-10", display_name: "Jon Doe", friends: [], user_id: 12345, username: "johnyap25")]

struct HomeView: View {
    @State var profiles: [UserAccount]
    
    var body: some View {
        NavigationView {
            List{
                ForEach(profiles) { profile in
                    NavigationLink(profile.display_name, destination: ProfileView(user:profile))
                }
            }
            .navigationTitle("Upcoming Birthdays")
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profiles: dummyFriends)
    }
}
