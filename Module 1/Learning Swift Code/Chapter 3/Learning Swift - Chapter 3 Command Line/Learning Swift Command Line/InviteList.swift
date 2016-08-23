//
//  InviteList.swift
//  Learning Swift Command Line
//
//  Created by Andrew J Wagner on 10/27/14.
//  Copyright (c) 2014 Drewag, LLC. All rights reserved.
//

import Foundation

// InviteList.swift
struct InviteList {
    var invited: [Invitee] = []
    var pendingInvitees: [Invitee]

    init(invitees: [Invitee]) {
        srand(UInt32(clock()))
        self.pendingInvitees = invitees
    }

    // Must be mutating because it calls another mutating method
    mutating func askRandomInviteeToBringGenre(genre: ShowGenre) {
        if self.pendingInvitees.count > 0 {
            let randomIndex = Int(rand()) % self.pendingInvitees.count
            let invitee = self.pendingInvitees[randomIndex]
            invitee.askToBringShowFromGenre(genre)
            self.invitedPendingInviteeAtIndex(randomIndex)
        }
    }

    // Must be mutating because it calls another mutating method
    mutating func inviteeRemainingInvitees() {
        while self.pendingInvitees.count > 0 {
            let invitee = self.pendingInvitees[0]
            invitee.askToBringThemselves()
            self.invitedPendingInviteeAtIndex(0)
        }
    }

    // Must be mutating because we are changing the contents of
    // our array properties
    mutating func invitedPendingInviteeAtIndex(index: Int) {
        // Removing an item from an array returns that item
        let invitee = self.pendingInvitees.removeAtIndex(index)
        self.invited.append(invitee)
    }
}