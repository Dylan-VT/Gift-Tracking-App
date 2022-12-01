//
//  ContentView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/20/22.
//

import SwiftUI

//This struct is made for the "Birthdays" NavTab
/*
struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
            }
            .navigationTitle("Home")
        }
    }
}
 */
//This struct is made for the "profile" NavTab
struct ConView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
            }
            .navigationTitle("Birthdays")
        }
    }
}
//This struct is made for the "Calendar View" NavTab
struct CalView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
            }
            .navigationTitle("Calendar View")
        }
    }
}


struct ContentView: View {
    @State var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    @State var friendsList: String = "2"
    
    //set tab bg color
    init() {
        UITabBar.appearance().backgroundColor = UIColor.blue
    }
    
    var body: some View {
        //the tab view section is where the tabs are called in the content view
        TabView {
            HomeView(profiles: dummyFriends)
                .tabItem {
                    Image(systemName:"person.2.fill")
                    Text("Birthdays")
                }
            ProfileView(user: $user)
                .tabItem {
                    Image(systemName: "gearshape.circle")
                    Text("Profile")
                }
//            PrivateProfileView(user: user)
//                .tabItem {
//                    Image(systemName: "gearshape.circle")
//                    Text("Profile")
//                }
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar View")
                }
            LoginView(user: $user, friendsList: $friendsList)
                .tabItem {
                    Image(systemName:
                        "key")
                    Text("Login")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
