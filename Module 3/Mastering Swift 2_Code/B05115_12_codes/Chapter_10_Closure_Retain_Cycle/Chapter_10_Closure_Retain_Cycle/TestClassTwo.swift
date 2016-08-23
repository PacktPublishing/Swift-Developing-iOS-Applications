//
//  TestClassTwo.swift
//  Chapter_10_Closure_Retain_Cycle
//
//  Created by Jon Hoffman on 1/31/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import Foundation

class TestClassTwo {
    
    func closureExample(handler: TestClassOne.nameClosure) {
        print(handler())
    }
    
    deinit {
        print("TestClassTwo deinitialized")
    }
}