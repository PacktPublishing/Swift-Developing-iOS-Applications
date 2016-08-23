//
//  MessageBuilder2.swift
//  ObjectiveCProject
//
//  Created by Jon Hoffman on 2/12/15.
//  Copyright (c) 2015 Jon Hoffman. All rights reserved.
//

import Foundation

class MessageBuilder: NSObject {
    
    func getPersonalizedMessage(name: String) -> String {
        let messages = Messages()
        let retMessage = "To: " + name + ", " + messages.getMessage()
        
        return retMessage;
    }
}