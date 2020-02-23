//
//  ViewController.swift
//  A2_P1_Houston_Morgan
//
//  Created by Morgan Houston on 9/11/19.
//  Copyright © 2019 Morgan Houston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel!
    var result: Double = 0.0
    var error: Error!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //adds border to label and default text to 0.
        myLabel.layer.borderColor = UIColor.black.cgColor
        myLabel.layer.borderWidth = 3.0
        myLabel.text = "0"
        
    }
    
    //for operation buttons
    @IBAction func buttons(_ sender: UIButton) {
        
        //if not blank or 'AC' or '=' then
        if myLabel.text != "" && sender.tag != 11 && sender.tag != 16 {
            
            //changes background to orange and text color to black
            myLabel.backgroundColor = UIColor.orange
            myLabel.textColor = UIColor.black
            if sender.tag == 12 { //adds Divide to label
                myLabel.text = myLabel.text! + "/"
            }
            
            if sender.tag == 13 { //adds Multiply to label
                myLabel.text = myLabel.text! + "*"
            }
            
            if sender.tag == 14 { //Subtract to label
                myLabel.text = myLabel.text! + "-"
            }
            
            if sender.tag == 15 { //Add to label
                myLabel.text = myLabel.text! + "+"
            }
            
            
        } else if sender.tag == 16 {
            
            //Found the 'Math' for calculations here: medium.com/@malcomcollin/building-a-calculator-in-swift-4-2116e3e45dd7
            //sets the expression to the format of our label
            let exp: NSExpression = NSExpression(format: myLabel.text!)
            
            //gets the result as a double value
            guard let result = try? exp.expressionValue(with: nil, context: nil) as? Double else { myLabel.backgroundColor = UIColor.red
                return }
            //if result is negative, bgcolor is black
            if result < 0 {
                myLabel.backgroundColor = UIColor.black
                myLabel.textColor = UIColor.orange
            } else if result > 0 {//positive, bgcolor is default
                
                myLabel.backgroundColor = UIColor.cyan
                myLabel.textColor = UIColor.black
            } else {//if result is 0, bgcolor is default
                myLabel.backgroundColor = UIColor.cyan
                myLabel.textColor = UIColor.black
            }
            //sets the format to up to 10 decimal places
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 10
            //transforms the result to a string and formats its places
            guard let value = formatter.string(from: NSNumber(value: result)) else { return }
            //sets my label to the formatted string
            myLabel.text = value
        }else if sender.tag == 11 {
            //Clears All
            myLabel.backgroundColor = UIColor.white
            myLabel.textColor = UIColor.black
            myLabel.text = "0"
            result = Double.nan;
        }
    }
    
    //for numbers and decimal
    @IBAction func numbers(_ sender: UIButton) {
        //clears the label
        if myLabel.text == "0" {
            myLabel.text = ""
        }
        //changes background color to green
        myLabel.backgroundColor = UIColor.green
        //if a number is pressed a number is added to the label
        if sender.tag > 0 {
            myLabel.text = myLabel.text! + String(sender.tag-1)
        } else {//else the decimal was pressed and is added to the label
            myLabel.text = myLabel.text! + "."
        }
      
    }
    

}

