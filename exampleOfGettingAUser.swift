import UIKit
import Foundation

var greeting = "Hello, playground"
let url = URL(string: "http://54.237.192.235/getuser/SomeUser123")!
print(0)
let task = URLSession.shared.dataTask(with: url) {data, response, error in
    if let data = data {
        let json = try? JSONSerialization.jsonObject(with: data)
        print(json)
    }

}

task.resume()

