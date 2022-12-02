//
//  HomeView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/20/22.
//

import SwiftUI

let dummyFriends: [UserAccount]  = [UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25"), UserAccount(birthday: "2001-10-10", display_name: "Jon Doe", friends: [], user_id: 12345, username: "johnyap25")]

struct HomeView: View {
    //create an instance of the ViewModel
    //@StateObject var viewModel = ViewModel()
    
    @Binding var profiles: [FriendEvent]
    
    
    var body: some View {
        NavigationView {
            List{
                ForEach(profiles.sorted(by: compEvent)) {profile in
                    NavigationLink(profile.username, destination: ProfileView(user: profile))
                    //}
                    //new loop for the users names
                    /*
                     ForEach(viewModel.users, id: \.self) { user in
                     //create a stack for the users
                     HStack {
                     Text(user.name)
                     .bold()
                     Text(user.bday)
                     .bold()
                     }
                     .padding(3)
                     } */
                }
                .navigationTitle("Upcoming Birthdays")
                //---------------------------
                //.onAppear {
                //  viewModel.fetchUser()
                //}
            }
        }
        //---------------------------
    }
    
    
    /*
     
     struct HomeView_Previews: PreviewProvider {
     @State var friends: [UserAccount] = dummyFriends
     static var previews: some View {
     HomeView(profiles: $friends)
     }
     }
     */
}

func compEvent(e1: FriendEvent, e2: FriendEvent) -> Bool{
    return  daysToBirthday(e1.event_date) < daysToBirthday(e2.event_date)
}

