package com.example.a6_p1_houston_morgan

import android.util.Log

class cash {
    //Array of the bills and coins
    val bills = arrayOf<Double>(50.00, 20.00, 10.00, 5.00, 1.00, 0.25, 0.10, 0.05, 0.01)

    //the total amount of money in dollars and cents
//    var money: Double = 0.0
//        get() = field
//        set(value) { field = value}


    //computed property of min number of bills and coins based on 'money' value
    fun findMin(money: Double): Array<Int>? {
        //found good information on codereview.stackexchange.com/questions/202696/dividing-an-arbitrary-dollar-amount-into-the-fewest-bills-and-coins
            //money must be positive
        Log.d("Money", "$money")
        if (money < 0) {
            return null
        }

            //tempArray is the array that will display how many of each bill or coin is needed
            //also creates a temp value and sets it to money
            var tempArray = arrayOf<Int>()
            var temp = money
            val billSize = bills.size-1

            //loop that calculates # of bills or coins and then subtracts that from the 'money' and adds it to the array for each iteration
            for (i in 0..billSize) {
                val count = (temp/bills[i]).toInt()
                temp -= count.toDouble() * bills[i]
                tempArray = tempArray.plus(count)
            }
            //returns min number of bills and coins
            return tempArray
        }

}

private operator fun <T> Array<T>.invoke() {

}
