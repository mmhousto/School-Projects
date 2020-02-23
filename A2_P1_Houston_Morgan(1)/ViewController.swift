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
    var decimalCount: Int = 0
    
    enum calcError: Error {
        case divisionError
        case inputError
        case unknownError
    }

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
        decimalCount = 0
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
            func convertToDouble() throws {
            //Found the 'Math' for calculations here: medium.com/@malcomcollin/building-a-calculator-in-swift-4-2116e3e45dd7
            //sets the expression to the format of our label
                guard myLabel.text?.contains("++")==false || myLabel.text?.contains("-+")==false || myLabel.text?.contains("+/")==false || myLabel.text?.contains("/+")==false || myLabel.text?.contains("-/")==false || myLabel.text?.contains("+*")==false || myLabel.text?.contains("-*")==false || myLabel.text?.contains("*+")==false || myLabel.text?.contains("//")==false || myLabel.text?.contains("/*")==false || myLabel.text?.contains("*/")==false || myLabel.text?.contains("/--")==false || myLabel.text?.contains("*--")==false || myLabel.text?.contains("+--")==false || myLabel.text?.contains("---")==false else {
                    throw calcError.inputError
                }
                let exp: NSExpression = NSExpression(format: myLabel.text!)
                do {
                    guard exp == NSExpression(format: myLabel.text!) else {
                        throw calcError.inputError
                    }
                } catch {
                    print(error)
                }
            
            //gets the result as a double value
                guard let result = exp.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double else {                     myLabel.backgroundColor = UIColor.red;
                    myLabel.text = "0"; throw calcError.unknownError
            }//checks if label contains division by zero
                guard myLabel.text?.contains("/0")==false else {
                    myLabel.backgroundColor = UIColor.red;
                    myLabel.text = "0"
                    throw calcError.divisionError
                }//checks if more than 1 decimal point is used.
                guard decimalCount <= 1 else {
                    myLabel.backgroundColor = UIColor.red;
                    myLabel.text = "0"
                    throw calcError.inputError
                }
                
    
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
            }
            do {
                try convertToDouble()
            } catch {
                print(error)
            }
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
            //adds 1 to decimal count
            myLabel.text = myLabel.text! + "."
            decimalCount += 1
        }
      
    }
    

}

extension NSExpression {
//https://stackoverflow.com/questions/46550658/can-i-force-nsexpression-and-expressionvalue-to-assume-doubles-instead-of-ints-s answer by Martin R
    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
            let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
            return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
            return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        @unknown default:
            fatalError()
        }
        return self
    }
}

