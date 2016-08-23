//
//  SerialQueues.swift
//  GCDTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class SerialQueues: NSObject {
   
    
    func example() {
        
        let calculation = DoCalculations()
        
        let queue2 = dispatch_queue_create("squeue.hoffman.jon", DISPATCH_QUEUE_SERIAL)
        //let queue2 = dispatch_get_main_queue();
        
        
        dispatch_async(queue2) {
            calculation.performCalculation(100000, tag: "sync1")
        }
        dispatch_async(queue2) {
            calculation.performCalculation(1000, tag: "sync2")
        }
        dispatch_async(queue2) {
            calculation.performCalculation(100000, tag: "sync3")
        }

    }
}
