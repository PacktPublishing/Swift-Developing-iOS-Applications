// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol QueueProtocol {
    typealias QueueType
    mutating func addItem(item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

class IntQueue: QueueProtocol {
    var items = [Int]()
    
    func addItem(item: Int) {
        items.append(item)
    }
    
    func getItem() -> Int? {
        if items.count > 0 {
            return items.removeAtIndex(0)
        } else {
            return nil
        }
    }
    
    func count() -> Int {
        return items.count
    }
}



var intQ = IntQueue()
intQ.addItem(2)
intQ.addItem(4)
print(intQ.getItem())
intQ.addItem(6)


class GenericQueue<T>: QueueProtocol {
    var items = [T]()
    
    func addItem(item: T) {
        items.append(item)
    }
    
    func getItem() -> T? {
        if items.count > 0 {
            return items.removeAtIndex(0)
        } else {
            return nil
        }
    }
    
    subscript(i:Int) -> T? {
        get {
            if items.count > i {
                return items[i]
            } else {
                return nil
            }
        }
    }
    
    func count() -> Int {
        return items.count
    }
}


var intQ2 = GenericQueue<Int>()
intQ2.addItem(2)
intQ2.addItem(4)
print(intQ2.getItem())
intQ2.addItem(6)
print(intQ2[1])
