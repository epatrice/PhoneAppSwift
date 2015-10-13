//
//  ViewController.swift
//  Calculator
//
//  Created by Eduardo Patrice on 10/13/15.
//  Copyright © 2015 Eduardo Patrice. All rights reserved.
//
//  This is a very simple calculator.
//  This is my first swift and xcode small project

import UIKit

class ViewController: UIViewController {
    
    var total:Int = 0
    var mode:Int = 0         // 1 = +, -1 = -, 2 = x, -2 = /
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    
    @IBOutlet weak var label: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedNumber(sender: UIButton) {
        let str:String! = sender.titleLabel!.text
        
        // prevent appending 0 to a total of 0 (don't want to display 00000)
        let num:Int! = Int(str)
        if( num == 0 && total == 0 )
        {
            return
        }
        
        if(lastButtonWasMode)
        {
            lastButtonWasMode = false
            valueString = ""
        }
        
        valueString = valueString.stringByAppendingString(str)
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        
        if(total == 0)
        {
            total = Int(valueString)!
        }
    }
    
    @IBAction func tappedPlus(sender: AnyObject) {
        self.setCalcMode(1)
    }
    
    @IBAction func tappedMinus(sender: AnyObject) {
        self.setCalcMode(-1)
    }
    
    @IBAction func tappedMultiply(sender: AnyObject) {
        self.setCalcMode(2)
    }
    

    @IBAction func tappedDivide(sender: AnyObject) {
        self.setCalcMode(-2)
    }
    
    @IBAction func tappedEqual(sender: AnyObject) {
        
        if(mode == 0)
        {
            return
        }
        
        // total is the value before the user press the current operator button
        // iNum is the new value after the most recent operator button
        let iNum:Int = Int(valueString)!
        
        if(mode == 1)
        {
            total += iNum
        }
        if(mode == -1)
        {
            total -= iNum
        }
        if(mode == 2)
        {
            total *= iNum
        }
        if(mode == -2)
        {
            total /= iNum
        }
        
        valueString = "\(total)"
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let n:NSNumber = formatter.numberFromString(valueString)!
        
        label.text = formatter.stringFromNumber(n)
        
        
        // reset mode to non operator
        mode = 0
    }
    
    @IBAction func tappedClear(sender: AnyObject) {
        total = 0
        mode = 0
        valueString = ""
        label.text = "0"
        lastButtonWasMode = false
    }
    
    func setCalcMode(m:Int)
    {
        if(total == 0)
        {
            return
        }
        
        mode = m
        lastButtonWasMode = true
        // backup the current total
        total = Int(valueString)!
        
    }


}

