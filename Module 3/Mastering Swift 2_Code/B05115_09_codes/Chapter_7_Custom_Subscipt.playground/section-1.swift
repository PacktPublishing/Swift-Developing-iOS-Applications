// Playground - noun: a place where people can play

import UIKit

struct MathTable {
    var num: Int
    
    subscript(multiply index: Int) -> Int {
        return num * index
    }
    
    subscript(addition index: Int) -> Int {
        return num + index
    }
    
    subscript(myRange aRange: Range<Int>) -> [Int] {
        var retArray: [Int] = []
        for i in aRange {
            retArray.append(self[multiply: i])
        }
        return retArray
    }
    
}

var table = MathTable(num: 5)

print(table[multiply: 4])
print(table[addition: 4])

print(table[myRange: 2...5])

print(table[myRange: 2..<5])


struct Hello {
    subscript (name: String) ->String {
        return "Hello \(name)"
    }
}

var hello = Hello()
print(hello["Jon"])










