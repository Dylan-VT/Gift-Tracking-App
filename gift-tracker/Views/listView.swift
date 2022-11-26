//
//  listView.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/17/22.
//

import SwiftUI
import Foundation

//userRow is new string for just the mapping of the json for mapping of json
struct UserROW: Hashable, Codable {
    let name: String
    let bday: String
}

class ViewModel: ObservableObject {
    @Published var users: [UserROW] = []
    
    func fetchUser() {
        //create url object and unwarp with guard let NOTE: For now it is hardcodded in
        guard let url = URL(string: "http://54.237.192.235/getuser/someUser1231") else { return }
        //perform apicall
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in guard let data = data, error == nil else { return }
        //conver to json
        do {
            //try json decoder
            let users = try JSONDecoder().decode([UserROW].self, from: data)
            //reminnd the view to update published proterty
            DispatchQueue.main.async {
                self?.users = users
            }
        }
        catch {
            //otherwise print the error
            print(error)
        }
        //END URLSession
        }
        task.resume()
    }
}

