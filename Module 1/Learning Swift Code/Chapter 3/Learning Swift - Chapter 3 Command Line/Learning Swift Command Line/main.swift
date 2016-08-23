//
//  main.swift
//  Learning Swift Command Line
//

import Foundation

var inviteeList = InviteList(invitees: [
    Invitee(name: "Sarah"),
    Invitee(name: "Jamison"),
    Invitee(name: "Marcos"),
    Invitee(name: "Roana"),
    Invitee(name: "Neena"),
])

let genres = [
    ShowGenre(name: "Comedy", example: "Modern Family"),
    ShowGenre(name: "Drama", example: "Breaking Bad"),
    ShowGenre(name: "Variety", example: "The Colbert Report"),
]

for genre in genres {
    inviteeList.askRandomInviteeToBringGenre(genre)
}
inviteeList.inviteeRemainingInvitees()

class SteeringWheel {
    var car: Car?
}

class Car {
    var steeringWheel: SteeringWheel
    
    init(steeringWheel: SteeringWheel) {
        self.steeringWheel = steeringWheel
        self.steeringWheel.car = self
    }
}

for var i = 0; i < 1000; i++ {
    let wheel = SteeringWheel()
    let car = Car(steeringWheel: wheel)
}