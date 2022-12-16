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

struct FriendEvent: Codable, Identifiable{
    var id: String{
        self.username
    }
    var event_for: Int
    var event_name: String
    var event_description: String
    var event_date: String
    var username: String
    
}

func getLogin(_ username: String, _ password: String,_ completion: @escaping (UserAccount?) -> Void){
    let url = URL(string: "http://54.237.192.235/getuser/\(username)/\(password)")!
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(UserAccount.self, from: data)
                print(json)
                completion(json)
            } catch {
                completion(nil)
                print(error)
            }

        }
        
    }
    task.resume()
    
}

func createUser(_ fullName: String,_ username: String,_ bday: String,_ pword: String, _ completion: @escaping (UserAccount?) -> Void){
    let url = URL(string: "http://54.237.192.235/createuser")!
    let values: [String: Any] = [
            "username": username,
            "display_name": fullName,
            "birthday": bday,
            "password": pword
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
                let json = try decoder.decode(UserAccount.self, from: data)
                print(json)
                completion(json)
            } catch {
                completion(nil)
                print(error)
            }
            
        }
        
    }).resume()
    
}

func getEvent(_ friendList: String,_ completion: @escaping ([FriendEvent]) -> Void){
    let url = URL(string: "http://54.237.192.235/getevents/\(friendList)")!
    print(url)
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode([FriendEvent].self, from: data)
                print("Here? \(json)")
                completion(json)
            } catch {
                print(error)
            }

        }
        
    }
    task.resume()
    
}




struct LoginView: View {
    @State var loggedIn :(success: Bool, erMessage: String) = (false, "")
    @State var username: String = ""
    @State var password: String = ""
    @State var erMesColor = Color.blue
    @Binding var user: UserAccount
    @Binding var friendsList: String
    @Binding var friendEvents: [FriendEvent]
    @Binding var passw: String
    var body: some View {

        NavigationView{
            //creates the outlines for the circle
            ZStack {
                //adds the extra circles for loginView
                Color.gray
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                
                VStack(alignment: .center,
                       spacing: 20){
                    Text("Log In")
                    //.offset()
                        .font(.system(size:32))
                        .cornerRadius(50.0)
                    Text(loggedIn.erMessage)
                        .foregroundColor(erMesColor)
                    TextField("Username", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 40)
                        .cornerRadius(50.0)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 40)
                        .cornerRadius(50.0)
                    Button("Sign In"){
                        loggedIn = signIn(username, password)
                        if loggedIn.success {
                            erMesColor = Color.blue
                            getFriendData(friendsList)
                            passw = password
                        }
                        else{
                            erMesColor = Color.red
                        }
                    }
                    .cornerRadius(10.0)
                    .padding(.vertical)
                    .padding(.horizontal, 120)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    Text("Or")
                    //.offset(y: 30)
                    NavigationLink(destination: CreateAccountView(user: $user, friendsList: $friendsList, friendEvents: $friendEvents)){
                        Text("Create an Account")
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .cornerRadius(10.0)
                }
            }
        }
    }
    func signIn(_ u: String, _ p: String)-> (success: Bool, erMessage: String){
        var suc: Bool = false
        let group = DispatchGroup()
        group.enter()
        getLogin(u, p, {data in
            if let dat = data{
                suc = true
                user.username = dat.username
                user.display_name = dat.display_name
                user.birthday = dat.birthday
                if let friends = dat.friends {
                    friendsList = friends.map {String($0)}.joined(separator: ",")
                    print("Friends: \(friendsList)")
        
                }
            }
            else{
                suc = false
            }
            group.leave()
            
        })
        group.wait()
        if suc{
            return (suc, "\(u) Successfully logged on")
        }
        else{
            return (suc, "The credentials you entered are incorrect")
        }
    }
    
    func getFriendData(_ friendList: String){
        if friendList == "" {
            friendEvents = []
        }
        else{
            getEvent(friendList, {data in
                friendEvents = data
            })
        }
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
    @State var erMesColor = Color.blue
    @Binding var user: UserAccount
    @Binding var friendsList: String
    @Binding var friendEvents: [FriendEvent]
    var body: some View{
        VStack(alignment: .center){
            Text("Create an Account")
                .font(.system(size: 32))
            Text(create.erMessage)
                .foregroundColor(erMesColor)
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
                    erMesColor = Color.blue
                    getFriendData(user.username)
                }
                else{
                    erMesColor = Color.red
                }
            }
                .padding(.vertical)
                .padding(.horizontal, 120)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
        }
    }
    func CreateAccount(_ name: String,_ username: String, _ bday: String, _ pass: String,_ pass2: String) -> (success: Bool, erMessage: String){
        var suc = true
        let group = DispatchGroup()
        group.enter()
        if pass != pass2{
            return (success: false, erMessage: "Passwords don't match")
        }
        else{
            createUser(name, username, bday, pass, {result in
                if let dat = result{
                    user.username = dat.username
                    user.display_name = dat.display_name
                    user.birthday = dat.birthday
                    if let friends = dat.friends {
                        friendsList = friends.map {String($0)}.joined(separator: ",")
                        print("Friends: \(friendsList)")
                    }
                }
                else{
                    suc = false
                }
                group.leave()
            })
            group.wait()
            if suc{
                return (success: suc, erMessage: "Account for \(name) successfully created")
            }
            else{
                return (suc, "Error creating account")
                
            }
        }
    }
    func getFriendData(_ friendList: String){
        if friendList == "" {
            friendEvents = []
        }
        else{
            getEvent(friendList, {data in
                friendEvents = data
            })
        }
    }
    
}


/*

struct LoginView_Previews: PreviewProvider {
    @State static var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    @State static var friendsList = "2"
    @State static var friendEvents: [FriendEvent] = []
    static var previews: some View {
        LoginView(loggedIn: (false, ""), user: $user, friendsList: $friendsList, friendEvents: $friendEvents, )
    }
}
*/
