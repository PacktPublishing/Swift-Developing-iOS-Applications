//
//  ViewController.swift
//  Chapter_10_Closure_Retain_Cycle
//
//  Created by Jon Hoffman on 1/31/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var testClassOne: TestClassOne? = TestClassOne()
        var testClassTwo: TestClassTwo? = TestClassTwo()
        
        testClassTwo?.closureExample(testClassOne!.myClosure)
        
        testClassOne = nil
        print("testClassOne is gone")
        
        testClassTwo = nil
        print("testClassTwo is gone")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

