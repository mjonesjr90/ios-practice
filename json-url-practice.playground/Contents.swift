//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

/**
By default, all top-level code is executed, and then execution is terminated. When working with asynchronous code, enable indefinite execution to allow execution to continue after the end of the playground’s top-level code is reached. This, in turn, gives threads and callbacks time to execute.
 */
PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "http://malcomjonesjr.com/nodes.json")
let config = URLSessionConfiguration.background(withIdentifier: "json_downlooad_config")
let session = URLSession(configuration: config)
let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
    if( error != nil) {
        print(error!)
    } else {
        if let urlContent = data {
            do {
                
                //AnyObject should be a dictionary
                let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options:[]) as! [String: AnyObject]
                
                //Extract array of Node dictionaries
                let jsonArray = jsonResult["Nodes"] as! [AnyObject]
                //print(jsonResult)
                //print(jsonResult["Nodes"]!!)
                
                for i in jsonArray {
                    let nodeID = i["NodeID"]
                    let lat = i["Lat"]
                    let long = i["Long"]
                    print("The location of node \(nodeID!!) is \(lat!!), \(long!!)")
                }
            } catch {
                print("JSON processing failed")
            }
        }
    }
}
task.resume()
