//
//  ContentView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/20/22.
//

import SwiftUI

func getEvent(_ friendList: String,_ completion: @escaping ([FriendEvent]) -> Void){
    let url = URL(string: "http://54.237.192.235/getevents/\(friendList)")!
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode([FriendEvent].self, from: data)
                print(json)
                completion(json)
            } catch {
                print(error)
            }

        }
        
    }
    task.resume()
    
}


struct FriendEvent: Codable, Identifiable{
    var id: String?
    var event_for: Int
    var event_name: String
    var event_description: String
    var event_date: String
    var username: String
    
}


struct ContentView: View {
    @State var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    @State var friendsList: String = "2"
    @State var friendEvents: [FriendEvent] = []
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
    func getFriendData(_ friendList: String) -> [UserAccount]{
        if friendList == "" {
            return []
        }
        else{
            getEvent(friendList, {data in
                friendEvents = data
            })
        }
        
        return []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




