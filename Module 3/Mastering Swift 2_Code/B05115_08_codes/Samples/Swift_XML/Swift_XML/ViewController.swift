//
//  ViewController.swift
//  Swift_XML
//
//  Created by Jon Hoffman on 12/24/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var xmlString = "<?xml version=\"1.0\"?><books><book name=\"iOS and OS X Network Development Cookbook\"><author>Jon Hoffman</author><publisher>PacktPub</publisher><category>Programming</category><description>Network development for iOS and OS X</description></book><book name=\"Mastering Swift\"><author>Jon Hoffman</author><publisher>PacktPub</publisher><category>Programming</category><description>Learning Swift</description></book></books>"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let xmlParser = MyXMLParser()
        xmlParser.parseXmlString(xmlString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

