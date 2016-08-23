// Playground - noun: a place where people can play

import UIKit

protocol TV {
    var currentChannel: Int {get set}
    
    func turnOn()
    func turnOff()
}

extension TV {
    mutating func changeChannel(channel: Int) {
        self.currentChannel = channel
    }
}

struct VizioTV: TV {
    
    var currentChannel = 1
    
    func turnOn() {
        print("Vizio On")
    }
    func turnOff() {
        print("Vizio Off")
    }
}

struct SonyTV: TV {
    
    var currentChannel = 1
    
    func turnOn() {
        print("Sony On")
    }
    func turnOff() {
        print("Sony Off")
    }
}

protocol RemoteControl {
    var tv: TV {get set}
    init(tv: TV)
}

extension RemoteControl {
    func turnOn() {
        tv.turnOn()
    }
    func turnOff() {
        tv.turnOff()
    }
    mutating func setChannel(channel: Int) {
        tv.changeChannel(channel)
    }
    mutating func nextChannel() {
        tv.changeChannel(tv.currentChannel + 1)
    }
    mutating func prevChannel() {
        tv.changeChannel(tv.currentChannel - 1)
    }
}

class MyUniversalRemote: RemoteControl {
    var tv: TV
    
    required init(tv: TV) {
        self.tv = tv
    }
}

var myTv = VizioTV()
var remote = MyUniversalRemote(tv: myTv)
remote.turnOn()
remote.nextChannel()
print("Channel on: \(myTv.currentChannel)")
remote.nextChannel()
print("Channel on: \(myTv.currentChannel)")
remote.turnOff()


