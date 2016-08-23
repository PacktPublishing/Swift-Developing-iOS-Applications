//
//  OperationWithBlockTest.swift
//  OperationQueueTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class OperationWithBlockTest: NSObject {
    
    func example() {
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        let calculation = DoCalculations()
        
        operationQueue.addOperationWithBlock() {
            calculation.performCalculation(10000000, tag: "Operation1")
        }
        
        operationQueue.addOperationWithBlock() {
            calculation.performCalculation(10000, tag: "Operation2")
        }
        
        operationQueue.addOperationWithBlock() {
            calculation.performCalculation(1000000, tag: "Operation3")
        }
    }
   
}
