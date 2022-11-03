//
//  ContentView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/20/22.
//
//defines the navigation bar 

import SwiftUI

//This struct is made for the "Birthdays" NavTab
struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
            }
            .navigationTitle("Profile")
        }
    }
}
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
    @State var loggedIn: Bool = false
    var body: some View {
        
        //the tab view section is where the tabs are called in the content view
        TabView {
            ConView()
                .tabItem {
                    Image(systemName:"person.fill")
                    Text("Birthdays")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "gearshape.circle")
                    Text("Profile")
                }
                
            CalView()
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
