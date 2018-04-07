//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

/**
By default, all top-level code is executed, and then execution is terminated. When working with asynchronous code, enable indefinite execution to allow execution to continue after the end of the playground’s top-level code is reached. This, in turn, gives threads and callbacks time to execute.
 */
PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "http://malcomjonesjr.com/json/hairtypes.json")
let config = URLSessionConfiguration.background(withIdentifier: "json_download_hairtypes")
let session = URLSession(configuration: config)
let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
    if( error != nil) {
        print(error!)
    } else {
        if let urlContent = data {
            do {
                
                //jsonResult will be a JSON Object in the form of a dictionary [String: AnyObject] - AnyObject will be an array of Hair Types
                let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:[]) as! [String: AnyObject]
                
                //Extract array of Hair Types
                let jsonArray = jsonResult["hair"] as! [AnyObject]
                //print(jsonResult)
                //print(jsonResult["Nodes"]!!)
                
                for i in jsonArray {
                    let typeName = i["name"]
                    let typeDesc = i["description"]
                    print("The hair type \(String(describing: typeName)) is \(String(describing: typeDesc))\n")
                }
            } catch {
                print("JSON processing failed")
            }
        }
    }
}
task.resume()
