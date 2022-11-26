//
//  BDayListView.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/15/22.
//

import SwiftUI
import UIKit
import Foundation


func getUser(_ username: String,_ completion: @escaping (UserAccount) -> Void){
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
struct BDayListView: View {
    /*
    Commented out code goes here
     */
    
    var body: some View {
       Text("HelloWorld")
    }
}
struct BDayListView_Previews: PreviewProvider {
    static var previews: some View {
        BDayListView()
    }
}

/*
@State var data: UserData

//function to get the data
func getData() {
    let url = URL(string: "http://54.237.192.235/getuser/someUser1231")
    URLSession.shared.dataTask(with: url!) {data, _, error in
        DispatchQueue.main.async {
        if let data = data {
            do{
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(UserData.self, from: data)
                self.data = decodedData
            } catch {
                    print("Error! Something went Wrong")
            }
        }
    }
}


var body: some View {
    VStack{
        Button("Refresh Data") {self.getData()}
        Text("\(data.realName.name)")
    }
}
 */

