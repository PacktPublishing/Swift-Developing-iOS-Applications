// Playground - noun: a place where people can play

import UIKit

var inum = 7    //Creates an Int
var dnum = 10.6 //Creates a Double

var insnum: NSNumber = inum  //Bridges the Int to a NSNumber
var dnsnum: NSNumber = dnum  //Bridges the Double to a NSNumber

var newint = Int(insnum)       //Creates an Int from a NSNumber
var newdouble = Double(dnsnum) //Creates a Double from a NSNumber
