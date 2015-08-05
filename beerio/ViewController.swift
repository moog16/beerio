//
//  ViewController.swift
//  beerio
//
//  Created by Matthew Goo on 8/4/15.
//  Copyright (c) 2015 mattgoo. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
//    var abvs = NSMutableArray()[]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showMeTheBeer(sender: AnyObject) {
        let urlPath = "http://api.brewerydb.com/v2/beers?key=23a5830b07861022a7cc05d6f9dc43af&ibu=80&hasLabels=y"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            if err != nil {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let json = JSON(jsonResult)
            let count: Int? = json["data"].array?.count
            println("found \(count!) beers")
            
            if let ct = count {
                for index in 0...ct-1 {
                    // println(json["data"][index]["challengeName"].string!)
                    if let name = json["data"][index]["abv"].string {
                        println(name)
                    }
                    
                }
            }
        })
        task.resume()
    }

}

