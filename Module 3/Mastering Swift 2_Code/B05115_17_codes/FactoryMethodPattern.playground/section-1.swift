// Playground - noun: a place where people can play

import UIKit

protocol Computer {
    func getType() -> String
}

class MacbookPro: Computer {
    func getType() -> String {
        return "Macbook Pro"
    }
}
class IMac: Computer {
    func getType() -> String {
        return "iMac"
    }
}

class MacMini: Computer {
    func getType() -> String {
        return "MacMini"
    }
}

class ComputerStore {
    enum ComputerType {
        case Laptop
        case Desktop
        case Headless
    }
    
    func getModel(type: ComputerType) -> Computer {
        switch(type) {
        case ComputerType.Laptop:
            return MacbookPro()
        case ComputerType.Desktop:
            return IMac()
        case ComputerType.Headless:
            return MacMini()
        }
    }
}

var store = ComputerStore()

var laptop = store.getModel(.Laptop)
print(laptop.getType())
