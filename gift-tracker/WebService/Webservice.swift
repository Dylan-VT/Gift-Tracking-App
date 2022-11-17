//
//  Webservice.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/17/22.
//
import SwiftUI
import Foundation

class Webservice {
    
    func getUsers(completion: @escaping ([User]?) -> ()) {
        //NOTE: for now the url is hardcoded in TODO: determine how to take input for url and still make it work
        guard let url = URL(string: "http://54.237.192.235/getuser/someUser1231") else {
            fatalError("Invalid IP")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                //completion handler
                completion(nil)
                }
                return
            }
            
            //by now the data shoud be a varable
            let users = try? JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
}
