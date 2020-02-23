//
//  Cash.swift
//  A1_P2_Houston_Morgan
//
//  Created by Morgan Houston on 9/3/19.
//  Copyright © 2019 Morgan Houston. All rights reserved.
//

import Foundation

public class Cash {
    //Array of the bills and coins
    let bills = [50.00, 20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01]
    
    //the total amount of money in dollars and cents
    var money: Double
    
    //initializer
    public init(money: Double) {
        self.money = money
    }
    
    //computed property of min number of bills and coins based on 'money' value
    public var minAmount: [Int]? {
    //found good information on codereview.stackexchange.com/questions/202696/dividing-an-arbitrary-dollar-amount-into-the-fewest-bills-and-coins
        get {
            //money must be positive
            guard money >= 0 else { return nil }
            
            //is the array that will display how many of each bill or coin is needed
            //also creates a temp value and sets it to money
            var tempArray = [Int]()
            var temp = money
            
            //loop that calculates # of bills and then subtracts that from the 'money' and adds it to the array for each iteration
                for i in 0..<bills.count {
                    let count = Int(temp/bills[i])
                    temp -= Double(count) * bills[i]
                    tempArray.append(count)
                }
            //returns min number of bills and coins
            return tempArray
        }
    }
    
}
