//
//  addFriendView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/29/22.
//

import SwiftUI

struct addFriendView: View {
    @State var friendUsername = ""
    @State var added = false
    @State var message = ""
    @State var messageColor = Color.blue
    var body: some View {
        NavigationView{
            VStack{
                Text(message)
                    .foregroundColor(messageColor)

                TextField("Username", text: $friendUsername)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
                Button("Add Friend"){
                    (added, message) = addFriend(friendUsername)
                    if added{
                        messageColor = Color.blue
                    }
                    else{
                        messageColor = Color.red
                    }
                }
            }
            .navigationTitle("Add Friend")
        }
    }
}

func addFriend(_ userName: String) -> (Bool, String){
    if userName == ""{
        return (false, "Error: No username given")
    }
    return (true, "\(userName) Added as Friend")
}

struct addFriendView_Previews: PreviewProvider {
    static var previews: some View {
        addFriendView()
    }
}
