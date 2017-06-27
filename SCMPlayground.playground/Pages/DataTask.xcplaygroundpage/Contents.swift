//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

// Let the playground do async requests
PlaygroundPage.current.needsIndefiniteExecution = true

struct Post {
    let id: Int
    let userID: Int
    let title: String
    let body: String
    
    init?(fromJSON json: Any) {
        
        // Serialize from the json if possible, else return nil
        
        guard let json = json as? [String: Any],
            let id = json["id"] as? Int,
            let userID = json["userId"] as? Int,
            let title = json["title"] as? String,
            let body = json["body"] as? String else {
                return nil
        }
        
        self.id = id
        self.userID = userID
        self.title = title
        self.body = body
    }
}

// POST

// You can use the shared session
let session = URLSession.shared

// Create the URL — you can just use a URL, but if you want to send params, you construct a URL request
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
let data: [String: Any] = ["userId": 1, "id": 1, "title": "Lorem ipsum", "body": "de lora solet"]

var request = URLRequest(url: url)

request.httpMethod = "POST"
request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])

session.dataTask(with: request) { (data, response, error) in
    if let data = data, let json = try? JSONSerialization.jsonObject(with: data) {
        print(json)
    }
    }.resume()

var num: Int?
if let blah = num {  }


// GET

// You just need a URL, nothing else
let getURL = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

session.dataTask(with: getURL) { (data, response, error) in
    if let data = data, let json = try? JSONSerialization.jsonObject(with: data), let post = Post(fromJSON: json) {
        print("\n------------------------ POST --------------------\n", post, "\n------------------------ POST --------------------\n")
    }
    }.resume()
