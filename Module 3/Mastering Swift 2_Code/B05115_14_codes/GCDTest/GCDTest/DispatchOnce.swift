//
//  DispatchOnce.swift
//  GCDTest
//
//  Created by Jon Hoffman on 2/28/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class DispatchOnce: NSObject {
    var token: dispatch_once_t = 0
    func example() {
        dispatch_once(&token) {
            print("Printed only on the first call")
        }
        print("Printed for each call")
    }
   
}
