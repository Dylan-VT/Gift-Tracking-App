//
//  addFriendView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/29/22.
//

import SwiftUI



func addNewFriend(_ thisUser: String,_ newFriend: String,_ completion: @escaping (Int) -> Void){
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
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Int.self, from: data)
                print(json)
                completion(json)
            } catch {
                completion(0)
                print(error)
            }
            
            
        }
        
    }).resume()
    
}
struct AddFriendView: View {
    @Binding var user: UserAccount
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
    func addFriend(_ userName: String) -> (Bool, String){
        var suc = false
        let group = DispatchGroup()
        group.enter()
        addNewFriend(user.username, userName, {result in
            suc = result == 200
            group.leave()
        }
            
        )
        group.wait()
        //Call to Database
        if suc{
            return (suc, "\(userName) Added as Friend")
        }
        else{
            return (suc, "Error, unable to add \(userName) as friend")
        }
    }
}



/*
struct addFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
*/
