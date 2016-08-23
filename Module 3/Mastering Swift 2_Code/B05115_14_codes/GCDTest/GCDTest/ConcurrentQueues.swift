//
//  ConcurrentQueues.swift
//  GCDTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ConcurrentQueues: NSObject {
    func example() {
        let calculation = DoCalculations()

        //let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let queue = dispatch_queue_create("cqueue.hoffman.jon", DISPATCH_QUEUE_CONCURRENT)
        
        //    let c = { calculation.performCalculation(10000000, tag: "async0") }
        //    dispatch_async(queue, c)
        
        dispatch_async(queue) {
        calculation.performCalculation(10000000, tag: "async1")
        }
        dispatch_async(queue) {
        calculation.performCalculation(1000, tag: "async2")
        }
        dispatch_async(queue) {
        calculation.performCalculation(100000, tag: "async3")
        }

    }
}
