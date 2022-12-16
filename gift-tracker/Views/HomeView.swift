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
    @State var sortBy = compDate
    @State var dateButCol = Color.myLightGreen
    @State var nameButCol = Color.gray
    @Binding var user: UserAccount
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Upcoming Birthdays")
                    .font(.title)
                    .foregroundColor(Color.white)
                HStack{
                    Text("Sort By:")
                        .foregroundColor(Color.white)
                    Spacer()
                    Button("Date"){
                        sortBy = compDate
                        dateButCol = Color.myLightGreen
                        nameButCol = Color.gray
                    }
                    .background(dateButCol)
                    .foregroundColor(Color.white)
                    Button("Name"){
                        sortBy = compName
                        dateButCol = Color.gray
                        nameButCol = Color.myLightGreen
                    }
                    .background(nameButCol)
                    .foregroundColor(Color.white)
                }
                .padding()
                VStack{
                        List{
                            ForEach(profiles.sorted(by: sortBy)) {profile in
                                NavigationLink(destination: ProfileView(user: profile, loggedInUser: $user)){
                                    HStack{
                                        Text(profile.username)
                                        Spacer()
                                        Text("\(daysToBirthday(profile.event_date)) days")
                                    }
                                }
                            }
                        }
                    }
                .background(Color.myBeige)
                }
            .background(Color.myDarkGreen)
            }
            
        }
        //---------------------------
    
    
    /*
     
     struct HomeView_Previews: PreviewProvider {
     @State var friends: [UserAccount] = dummyFriends
     static var previews: some View {
     HomeView(profiles: $friends)
     }
     }
     */
}

func compDate(e1: FriendEvent, e2: FriendEvent) -> Bool{
    return  daysToBirthday(e1.event_date) < daysToBirthday(e2.event_date)
}

func compName(e1: FriendEvent, e2: FriendEvent) -> Bool{
    return e1.username.lowercased() < e2.username.lowercased()
}
