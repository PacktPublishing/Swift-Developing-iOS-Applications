//
//  ViewController.swift
//  AppleRestSample
//
//  Created by Jon Hoffman on 3/10/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let printResultsClosure: HttpConnect.dataFromURLCompletionClosure = {

            if let data = $1 {
                let sString = NSString(data: data, encoding: NSUTF8StringEncoding)
                print(sString)
            } else {
                print("Data is nil")
            }
        }
        let aConnect = HttpConnect()
        aConnect.sendGetRequest(printResultsClosure)

    //            aConnect.postConnect(printResultsClosure);
  
        let reachable = aConnect.networkConnectionType("packtpub.com")
        switch (reachable) {
        case HttpConnect.ConnectionType.MOBILE3GNETWORK:
            print("Mobile Connection")
        case HttpConnect.ConnectionType.WIFINETWORK:
            print("WIFI Conenction")
        default:
            print("No Connection")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

