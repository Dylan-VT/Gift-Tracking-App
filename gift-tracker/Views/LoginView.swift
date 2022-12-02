//
//  LoginView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/2/22.
//

import SwiftUI
import Foundation

struct UserAccount: Codable, Identifiable{
    var id: String?
    var birthday: String
    var display_name: String
    var friends: Array<Int>?
    var user_id: Int
    var username: String
}

func getLogin(_ username: String, _ password: String,_ completion: @escaping (UserAccount) -> Void){
    let url = URL(string: "http://54.237.192.235/getuser/\(username)")!
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(UserAccount.self, from: data)
                print(json)
                completion(json)
            } catch {
                print(error)
            }

        }
        
    }
    task.resume()
    
}

func createUser(_ fullName: String,_ username: String,_ bday: String, _ completion: @escaping (URLResponse) -> Void){
    let url = URL(string: "http://54.237.192.235/createuser")!
    let values: [String: Any] = [
            "username": username,
            "display_name": fullName,
            "birthday": bday
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

struct LoginView: View {
    @State var loggedIn :(success: Bool, erMessage: String) = (false, "")
    @State var username: String = ""
    @State var password: String = ""
    @Binding var user: UserAccount
    @Binding var friendsList: String
    var body: some View {
        NavigationView{
            VStack(alignment: .center,
                   spacing: 20){
                Text("Log In")
                //.offset()
                    .font(.system(size:32))
                Text(loggedIn.erMessage)
                    .foregroundColor(.red)
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
                Button("Sign In"){
                    loggedIn = signIn(username, password)
                    if loggedIn.success {
                    }
                }
                    .padding(.vertical)
                    .padding(.horizontal, 120)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                Text("Or")
                //.offset(y: 30)
                NavigationLink(destination: CreateAccountView()){
                    Text("Create an Account")
                }
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
            }
        }
    }
    func signIn(_ u: String, _ p: String)-> (success: Bool, erMessage: String){
        getLogin(u, p, {data in
            user.username = data.username
            user.display_name = data.display_name
            user.birthday = data.birthday
            if let friends = data.friends {
                friendsList = friends.map {String($0)}.joined(separator: ",")
                print(friendsList)
                
            }
            
        })
        return (false, "\(u) \(p)")
    }
    
}

struct CreateAccountView: View{
    @State var full_name: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var birthYear: String = ""
    @State var birthMonth: String = ""
    @State var birthDay: String = ""
    @State var bday: String = ""
    @State var confirmPassword: String = ""
    @State var create: (success: Bool, erMessage: String) = (false, "")
    var body: some View{
        VStack(alignment: .center){
            Text("Create an Account")
                .font(.system(size: 32))
            Text(create.erMessage)
                .foregroundColor(.red)
            TextField("Full Name", text: $full_name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            Text("Birthday")
            HStack{
                TextField("MM", text: $birthMonth)
                    .padding(.leading, 40)
                    .textFieldStyle(.roundedBorder)
                TextField("DD", text: $birthDay)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 12)
                TextField("YYYY", text: $birthYear)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 40)
            }
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            TextField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            Button("Create"){
                bday = "\(birthYear)-\(birthMonth)-\(birthDay)"
                create = CreateAccount(full_name, username, bday, password, confirmPassword)
                if create.success{
                }
            }
                .padding(.vertical)
                .padding(.horizontal, 120)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
        }
    }
    func CreateAccount(_ name: String,_ user: String, _ bday: String, _ pass: String,_ pass2: String) -> (success: Bool, erMessage: String){
        if pass != pass2{
            return (success: false, erMessage: "Passwords don't match")
        }
        else{
            createUser(name, user, bday, {result in
                print(result)
            })
            return (success: true, erMessage: "Account for \(name) successfully created")
        }
    }
}




struct LoginView_Previews: PreviewProvider {
    @State static var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    @State static var friendsList = "2"
    static var previews: some View {
        LoginView(loggedIn: (false, ""), user: $user, friendsList: $friendsList)
    }
}
