// Playground - noun: a place where people can play

import UIKit

class MySingleton {
    
    var number = 0
    
    private init() {}
    
    static let sharedInstance = MySingleton()
}

var singleA = MySingleton.sharedInstance
singleA.number = 1

var singleB = MySingleton.sharedInstance
singleB.number = 2

print(singleA.number)
print(singleB.number)

var singleC = MySingleton.sharedInstance
singleB.number = 3

print(singleA.number)
print(singleB.number)
print(singleC.number)
