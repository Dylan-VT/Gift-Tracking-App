//
//  ContentView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/20/22.
//

import SwiftUI




struct ContentView: View {
    init() {
            UITabBar.appearance().backgroundColor = UIColor.green.withAlphaComponent(0.3)
        }
    @State var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    @State var friendsList: String = "2"
    @State var friendEvents: [FriendEvent] = []
    @State var password = ""
    var body: some View {
        //the tab view section is where the tabs are called in the content view
        TabView {
            LoginView(user: $user, friendsList: $friendsList, friendEvents: $friendEvents, passw: $password)
                .tabItem {
                    Image(systemName:
                        "key")
                    Text("Login")
                }
            HomeView(profiles: $friendEvents, user: $user)
                .tabItem {
                    Image(systemName:"person.2.fill")
                    Text("Birthdays")
                }
            PrivateProfileView(user: $user, friendsList: $friendsList, friendEvents: $friendEvents, password: $password)
                .tabItem {
                    Image(systemName: "gearshape.circle")
                    Text("Profile")
                }
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar View")
                }
                
            
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




