//
//  Guests.swift
//  Useful_Closures_2
//
//  Created by Jon Hoffman on 1/26/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import Foundation

class Guests {
    var guestNames = ["Jon","Kim","Kailey","Kara","Buddy","Lily","Dash"]
    
    typealias UseArrayClosure = (([String]) -> Void)
    
    func getGuest(handler:UseArrayClosure) {
        handler(guestNames)
    }

}