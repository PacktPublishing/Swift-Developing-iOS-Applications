//
//  ViewController.swift
//  StrongReferenceCycleProject
//
//  Created by Jon Hoffman on 12/22/14.
//  Copyright (c) 2014 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testStrongRefCycle()
        testUnwnedRefCycle()
        testWeakRefCycle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testStrongRefCycle() {
        print("----------Strong-------------")
        var class1: MyClass1? = MyClass1(name: "Class1")
        var class2: MyClass2? = MyClass2(name: "Class2")
        
        class1?.class2 = class2
        class2?.class1 = class1
        
        print("Setting classes to nil")
        class2 = nil
        class1 = nil
    }

    func testUnwnedRefCycle() {
        print("----------Unowned-------------")
        let class4 = MyClass4(name: "Class4")
        let class3: MyClass3? = MyClass3(name: "class3", class4: class4)
        
        class4.class3 = class3
        
        print("Classes going out of scope")
        
    }
    
    func testWeakRefCycle() {
        print("----------Weak-------------")
        let class5: MyClass5? = MyClass5(name: "Class5")
        let class6: MyClass6? = MyClass6(name: "Class6")
        
        class5?.class6 = class6
        class6?.class5 = class5
        
        print("Classes going out of scope")

    }

}

