//
//  main.swift
//  ObjectiveCAndSwift
//
//  Created by Andrew Wagner on 12/26/15.
//  Copyright © 2015 Andrew Wagner. All rights reserved.
//

import Foundation

// Function

var inviteeList: [String] = []
addInviteeToListIfSpotAvailable(inviteeList, "Sarah")

// Type, methods, and properties

var contact = Contact()
contact.firstName = "First"
contact.lastName = "Last"
contact.addToInviteeList(inviteeList, includeLastName: false)

// Enumeration

var color: PrimaryColor = PrimaryColorRed

// Bridging back to a Swift array
inviteeList = contact.addToInviteeList(
    inviteeList,
    includeLastName: false
    ) as! [String]


// Annotated to not be null
inviteeList = contact.addToInviteeList(inviteeList) as! [String]

// Annotated for element type
inviteeList = contact.addStringToInviteeList(inviteeList)