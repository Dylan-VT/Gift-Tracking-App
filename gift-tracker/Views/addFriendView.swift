//
//  addFriendView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/29/22.
//

import SwiftUI



func addNewFriend(_ thisUser: String,_ newFriend: String,_ completion: @escaping (URLResponse) -> Void){
    let url = URL(string: "http://54.237.192.235/addfriend")!
    let values: [String: Any] = [
            "username": thisUser,
            "new_friend": newFriend
    ]
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "accept")
    
    guard let httpBody = try? JSONSerialization.data(withJSONObject: values)
        else {
        print("Error serializing new friend body")
        return
    }
    request.httpBody = httpBody
    let session = URLSession.shared
    session.dataTask(with: request, completionHandler: { data, res, err in
        if let res = res {
            print(res)
            completion(res)
            
            
        }
        
    }).resume()
    
}
struct AddFriendView: View {
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
                    .padding(.vertical, 15)
                Button("Add Friend"){
                    (added, message) = addFriend(friendUsername)
                    if added{
                        messageColor = Color.blue
                    }
                    else{
                        messageColor = Color.red
                    }
                }
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
            .navigationTitle("Add Friend")
        }
    }
}

func addFriend(_ userName: String) -> (Bool, String){
    addNewFriend("Dylan2134", userName, {result in
        print(result)
    }
        
    )
    //Call to Database
    return (true, "\(userName) Added as Friend")
}

struct addFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}

