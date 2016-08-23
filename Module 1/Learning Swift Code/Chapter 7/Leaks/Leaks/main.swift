//
//  main.swift
//  Leaks
//
//  Created by Andrew Wagner on 2/7/16.
//  Copyright © 2016 Learning Swift. All rights reserved.
//

import Foundation

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

func createLeak() {
    let steeringWheel = SteeringWheel()
    let car = Car(steeringWheel: steeringWheel)
    print(car)
}

for _ in 0 ..< 5 {
    createLeak()
    sleep(1)
}