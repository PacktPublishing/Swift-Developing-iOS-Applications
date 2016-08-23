//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



func guardFunction1(str: String?) {
    guard let goodStr = str else {
        print("Input was nil")
        return
    }
    print("Input was \(goodStr)")
}

guardFunction1("Hello")

func guardFunction2(str: String) {
    guard let num = Int(str) else {
        print("Input is not a number")
        return
    }
    
    print("Input is the number \(num)")
}

guardFunction2("555")


func isValidIP(ipAddr: String?) -> Bool {

    guard let ipAddr = ipAddr else {
        return false
    }
    
    let octets = ipAddr.characters.split { $0 == "."}.map{String($0)}
    
    guard octets.count == 4 else {
        return false
    }
    
    func validOctet(octet: String) -> Bool {
        guard let num = Int(String(octet))
            where num >= 0 && num < 256 else {
                return false
        }
        return true
    }
    
    for octet in octets {
        guard validOctet(octet) else {
            return false
        }
    }
    
    return true

}

print(isValidIP("10.1.1.100"))
