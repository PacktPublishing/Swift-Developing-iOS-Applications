//
//  Messages.swift
//  SwiftProject
//
//  Created by Jon Hoffman on 2/13/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import Foundation

class Messages: NSObject {

    private var messages = [String]()
    
    override init() {
        messages.append("You should learn from your mistakes")
        messages.append("It is in the now that we must live")
        messages.append("The greatest risk is not taking one")
        messages.append("You will be a Swift programmer")
    }
    
    func getMessage() -> String {
        let num = Int(arc4random()) % messages.count
        return messages[num]
    }
}
