//
//  Invitee.swift
//  Learning Swift Command Line
//
//  Created by Andrew J Wagner on 10/26/14.
//  Copyright (c) 2014 Drewag, LLC. All rights reserved.
//

import Foundation

// Invitee.swift
struct Invitee {
    let name: String

    func askToBringShowFromGenre(genre: ShowGenre) {
        print("\(self.name), bring a \(genre.name) show")
        print("\(genre.example) is a great \(genre.name)")
    }

    func askToBringThemselves() {
        print("\(self.name), just bring yourself")
    }
}