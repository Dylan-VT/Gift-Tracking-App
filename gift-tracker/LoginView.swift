//
//  LoginView.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 11/2/22.
//

import SwiftUI

struct LoginView: View {
    @State var loggedIn: Bool
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            VStack(alignment: .center,
                   spacing: 20){
                Text("Log In")
                //.offset()
                    .font(.system(size:32))
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
                Button("Sign In"){
                    loggedIn = signIn(username, password)
                    
                }
                Text("Or")
                //.offset(y: 30)
                NavigationLink(destination: CreateAccountView()){
                    Text("Create an Account")
                }
                
            }
        }
    }
    func signIn(_ u: String,_ p: String)-> Bool{
        return true
    }
    
}

struct CreateAccountView: View{
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    var body: some View{
        VStack(alignment: .center){
            Text("Create an Account")
                .font(.system(size: 32))
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
                var create = CreateAccount(email, username, password, confirmPassword)
                if create.success{
                    1+1
                }
                else{
                    print(create.erMessage)
                }
            }
        }
    }
    func CreateAccount(_ e: String,_ u: String,_ p: String,_ p2: String) -> (success: Bool, erMessage: String){
        return (success: false, "Passwords don't match")
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: false)
    }
}