//
//  DispatchAfter.swift
//  GCDTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class DispatchAfter: NSObject {
    func example() {
        
        let calculation = DoCalculations()
        
        let queue2 = dispatch_queue_create("squeue.hoffman.jon", DISPATCH_QUEUE_SERIAL)
        
        let delayInSeconds = 2.0
        let pTime = dispatch_time(DISPATCH_TIME_NOW,Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(pTime, queue2) {
            print("Times Up")
        }
        
        dispatch_sync(queue2) {
            calculation.performCalculation(100000, tag: "dispatch after sync1")
        }

    }
}
