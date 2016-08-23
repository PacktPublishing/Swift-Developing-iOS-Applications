// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class List<T> {
    var items = [T]()
    
    func addItem(item: T) {
        items.append(item)
    }
    
    func getItemAtIndex(index: Int) -> T? {
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
    
}
var list = List<String>()
list.addItem("Hello")
list.addItem("World")
print(list.getItemAtIndex(1))



struct GenericStruct<T: Comparable> {
    
}

enum GenericEnum<T> {
    
}
