//
//  ViewController.swift
//  AndreaTest
//
//  Created by Nestor Bermudez Sarmiento on 9/10/15.
//  Copyright (c) 2015 Nestor Bermudez. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    typealias ServiceResponse = (NSDictionary?, NSError?) -> Void
    typealias JSON = NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func makePost(sender: AnyObject) {
        let url = "https://opentokrtc-backend.herokuapp.com/create-new-room"
        makeHTTPPostRequest(url, body: ["params": ["room_name": "Nestor", "name": "Andrea", "message": "hola :)"]], onCompletion: { (json, error) in
            print(json)
        })
    }
    
    func makeHTTPPostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        // Set the POST body for the request
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body["params"]!, options:nil, error: &err)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let parsed = NSString(data: data, encoding: NSUTF8StringEncoding)
            let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            print(jsonObject)
        })
        task.resume()
    }
}

