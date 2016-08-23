//
//  MyOperation.swift
//  OperationQueueTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class MyOperation: NSOperation {
    let iterations: Int
    let tag: String
    
    init(iterations: Int, tag: String) {
        self.iterations = iterations
        self.tag = tag
    }
    
    override func main() {
        performCalculation()
    }
    
    func performCalculation() {
        let start = CFAbsoluteTimeGetCurrent()
        for var i=0; i<iterations; i++ {
            self.doCalc()
        }
        let end = CFAbsoluteTimeGetCurrent()
        print("time for \(tag):  \(end-start)")
    }
    
    func doCalc() {
        let x=100
        let y = x*x
        _ = y/x
    }
}
