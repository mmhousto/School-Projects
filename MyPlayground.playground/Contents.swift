import UIKit
//imports module giving access to Cash
import A1_P2_Houston_Morgan

//sets c0 'money' to negative c1 to 0 and the rest to a random double between 1 and 100 inclusive rounded to two decimal places.
let c0 = Cash.init(money: -15.98)
let c1 = Cash.init(money: 0)
let c2 = Cash.init(money: (Double.random(in: 1 ... 100)*100).rounded()/100)
let c3 = Cash.init(money: (Double.random(in: 1 ... 100)*100).rounded()/100)
let c4 = Cash.init(money: (Double.random(in: 1 ... 100)*100).rounded()/100)
let c5 = Cash.init(money: (Double.random(in: 1 ... 100)*100).rounded()/100)

//Prints the minAmount array of c0-c5 based on the 'money'
print(c0.minAmount!)
print(c1.minAmount!)
print(c2.minAmount!)
print(c3.minAmount!)
print(c4.minAmount!)
print(c5.minAmount!)

