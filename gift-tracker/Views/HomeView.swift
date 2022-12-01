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
    
    @State var profiles: [UserAccount]
    
    var body: some View {
        NavigationView {
            List{
                ForEach(profiles) {profile in
                    //TODO - change to ProfileView
                    NavigationLink(profile.display_name, destination: PrivateProfileView(user: profile))
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
