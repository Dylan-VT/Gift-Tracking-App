//
//  LoginView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/2/22.
//

import SwiftUI
import Foundation

struct UserAccount: Codable {
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
                Text("Or")
                //.offset(y: 30)
                NavigationLink(destination: CreateAccountView()){
                    Text("Create an Account")
                }
            }
        }
    }
    func signIn(_ u: String, _ p: String)-> (success: Bool, erMessage: String){
        print(getLogin(u, p, {data in
            print(data)
            print(data.username)
        }))
        return (false, "\(u) \(p)")
    }
    
}

struct CreateAccountView: View{
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var create: (success: Bool, erMessage: String) = (false, "")
    var body: some View{
        VStack(alignment: .center){
            Text("Create an Account")
                .font(.system(size: 32))
            Text(create.erMessage)
                .foregroundColor(.red)
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            TextField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            TextField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 40)
            Button("Create"){
                create = CreateAccount(email, username, password, confirmPassword)
                if create.success{
                }
            }
        }
    }
    func CreateAccount(_ e: String,_ u: String,_ p: String,_ p2: String) -> (success: Bool, erMessage: String){

        return (success: false, erMessage: "Passwords don't match")
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: (false, ""))
    }
}
