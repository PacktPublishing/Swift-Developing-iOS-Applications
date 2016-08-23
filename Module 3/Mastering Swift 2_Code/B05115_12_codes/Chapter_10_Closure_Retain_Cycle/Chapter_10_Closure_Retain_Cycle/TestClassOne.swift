//
//  TestClass.swift
//  Chapter_10_Closure_Retain_Cycle
//
//  Created by Jon Hoffman on 1/31/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import Foundation

class TestClassOne {
    typealias nameClosure = (() -> String)
    
    var name = "Jon"
    
    lazy var myClosure: nameClosure =  {
        [unowned self] in
        return self.name
    }
    
    deinit {
        print("TestClassOne deinitialized")
    }
}




