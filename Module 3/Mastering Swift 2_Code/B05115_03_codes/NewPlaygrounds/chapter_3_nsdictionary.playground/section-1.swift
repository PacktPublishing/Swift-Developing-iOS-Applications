// Playground - noun: a place where people can play

import UIKit

var nsdic: NSDictionary = ["one":"HI", "two":"There"]
if let dic = nsdic as? [String: String] {
    var newDic = dic as NSDictionary
}

var nsdic2: NSDictionary = ["one":"HI", "two":2]
if let dic2 = nsdic2 as? [String:String] {
    // Would not reach this becuase 
    // conversion failed
}

var nsdic3: NSDictionary = ["One":"HI", "two": 2]
var dic3:Dictionary? = nsdic3 as? [String:AnyObject]
var newDic3 = dic3 as? [String:String]