package com.example.a6_p1_houston_morgan

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import kotlin.random.Random

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val c = cash()

//sets c0 'money' to negative, c1 to 0, and the rest to a random double between 1 and 100 inclusive rounded to two decimal places.
        var c0: Array<Int>? = c.findMin(-15.98)
        Log.d("Test0", "c0 = $c0")

        var c1: Array<Int>? = c.findMin(0.0)
        var string1: String = ""
        c1?.forEach { string1 += "$it " }
        Log.d("Test1", "c1 = $string1")

        var c2: Array<Int>? = c.findMin(Math.round(Random.nextDouble(1.00, 100.00) * 100.0) / 100.0)
        var string2: String = ""
        c2?.forEach { string2 += "$it " }
        Log.d("Test2", "c2 = $string2")

        var c3: Array<Int>? = c.findMin(Math.round(Random.nextDouble(1.00, 100.00) * 100.0) / 100.0)
        var string3: String = ""
        c3?.forEach { string3 += "$it " }
        Log.d("Test3", "c3 = $string3")

        var c4: Array<Int>? = c.findMin(Math.round(Random.nextDouble(1.00, 100.00) * 100.0) / 100.0)
        var string4: String = ""
        c4?.forEach { string4 += "$it " }
        Log.d("Test4", "c4 = $string4")

        var c5: Array<Int>? = c.findMin(Math.round(Random.nextDouble(1.00, 100.00) * 100.0) / 100.0)
        var string5: String = ""
        c5?.forEach { string5 += "$it " }
        Log.d("Test5", "c5 = $string5")
    }
}
