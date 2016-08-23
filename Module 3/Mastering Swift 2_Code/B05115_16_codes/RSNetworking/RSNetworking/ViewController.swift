//
//  ViewController.swift
//  RSNetworking
//
//  Created by Jon Hoffman on 3/20/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   //     rsURLRequestExample()
    
        rsTransactionExample()
        
        let url = "http://is4.mzstatic.com/image/pf/us/r30/Features/2a/b7/da/dj.kkirmfzh.100x100-75.jpg"
        if let iView: UIImageView = imageView, image = UIImage(named: "loading") {
                iView.setImageForURL(url, placeHolder: image)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    private func rsTransactionExample() {
        
       /* let rsTransGet = RSTransaction(transactionType: RSTransactionType.GET, baseURL: "https://itunes.apple.com", path: "search", parameters: ["term":"jimmy+buffett","media":"music"])
        makeRSRequest(rsTransGet)
        
        
        rsTransGet.parameters = ["term":"jim","media":"music"]
        makeRSRequest(rsTransGet) */
        
        let rsRequest = RSTransactionRequest()
        
        //First request
        let rsTransGet = RSTransaction(transactionType:RSTransactionType.GET, baseURL: "https://itunes.apple.com", path: "search", parameters: ["term":"jimmy+buffett", "media":"music"])
        rsRequest.dictionaryFromRSTransaction(rsTransGet, completionHandler: resultsHandler)
        
        //Second request
        rsTransGet.parameters = ["term":"jim", "media":"music"]
        rsRequest.dictionaryFromRSTransaction(rsTransGet, completionHandler: resultsHandler)
    }
    
    private func makeRSRequest(tran:RSTransaction) {
        let rsRequest = RSTransactionRequest()
        
        rsRequest.dictionaryFromRSTransaction(tran , completionHandler: resultsHandler)
    }
    
    
    private func rsURLRequestExample() {
        let client = RSURLRequest()
        
        if let testURL = NSURL(string:"https://itunes.apple.com/search?term=jimmy+buffett&media=music") {
            
            client.dictionaryFromJsonURL(testURL, completionHandler: resultsHandler)
        }
    }
    
    
    private var resultsHandler:RSURLRequest.dictionaryFromURLCompletionClosure = {
        var response = $0
        var responseDictionary = $1
        var error = $2
        if error == nil {
            let res = "results"
            if let results = responseDictionary[res] as? NSArray {
                print(results[0])
                
            } else {
                print("Problem")
            }
        } else {
            //If there was an error, log it
            print("Error : \(error)")
        }
    }
    
}

