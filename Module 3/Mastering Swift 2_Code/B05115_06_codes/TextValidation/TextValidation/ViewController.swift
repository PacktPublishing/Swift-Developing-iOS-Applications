//
//  ViewController.swift
//  TextValidation
//
//  Created by Jon Hoffman on 8/11/15.
//  Copyright © 2015 Jon Hoffman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var alphaTextField: UITextField?
    @IBOutlet var alphaNumericTextField: UITextField?
    @IBOutlet var displayNameTextField: UITextField?
    @IBOutlet var messageLabel: UILabel?
    
    var validators = [UITextField: TextValidationProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let alphaTextField = alphaTextField, alphaNumericTextField = alphaNumericTextField, displayNameTextField = displayNameTextField {
            
            alphaTextField.addTarget(self, action: Selector("keyPressed:"), forControlEvents: UIControlEvents.EditingChanged)
            alphaNumericTextField.addTarget(self, action: Selector("keyPressed:"), forControlEvents: UIControlEvents.EditingChanged)
            displayNameTextField.addTarget(self, action: Selector("keyPressed:"), forControlEvents: UIControlEvents.EditingChanged)
            
            validators[alphaTextField] = AlphaValidation.sharedInstance
            validators[alphaNumericTextField] = AlphaNumericValidation.sharedInstance
            validators[displayNameTextField] = DisplayNameValidation.sharedInstance
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyPressed(textField: UITextField) {
        if let validator = validators[textField] where !validator.validateString(textField.text!) {
            textField.text = validator.getMatchingString(textField.text!)
            messageLabel?.text = validator.validationMessage
        }
    }
    
}

