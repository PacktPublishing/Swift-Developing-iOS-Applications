//
//  ViewController.swift
//  TestArcProject
//
//  Created by Jon Hoffman on 12/22/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testFunc()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testFunc() {
        var class1ref1: MyClass? = MyClass(name: "One")
        var class2ref1: MyClass? = MyClass(name: "Two")
        var class2ref2: MyClass? = class2ref1
        
        print("Setting class1ref1 to nil")
        class1ref1 = nil
        
        print("Setting class2ref1 to nil")
        class2ref1 = nil
        
        print("Setting class2ref2 to nil")
        class2ref2 = nil
        
    }


}

