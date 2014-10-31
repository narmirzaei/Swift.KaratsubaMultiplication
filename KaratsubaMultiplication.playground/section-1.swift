//
//  KaratsubaMultiplication.playground
//
//  Created by Narbeh Mirzaei on 10/30/14.
//  Copyright (c) 2014 Narbeh Mirzaei. All rights reserved.
//
//  http://en.wikipedia.org/wiki/Karatsuba_algorithm

/* This is the v1.0 and it was my first attempt to implement Karatsuba Multiplication algorithm in Swift. I'm pretty new to Swift so I'm pretty confident there are better ways  to implement this. For the v2.0 I'll rely on Strings in order to be able to bypass size limitations on Integers and multiply much larger Integers. */

import UIKit

func lengthOf(x : UInt64) -> Int {
    return countElements(String(x)) //calculating the length of an integer by converting it to String and get String.length. Not efficient though
}

func split(x : UInt64) -> (x: UInt64, y: UInt64) {
    let denominator = UInt64(pow(10, Double(lengthOf(x) / 2))) //the denominator that is used to split the integer
    return (x / denominator, x % denominator) //split 1234 into 12 and 34
}

func productOf(x : UInt64, y : UInt64) -> UInt64? {
    if x < 0 || y < 0 {
        return nil
    }
    
    let length = max(lengthOf(x), lengthOf(y)) //in case we have two integers with different lengths
    
    if(length < 10) { //base case
        return x * y
    }
    
    let (a,b) = split(x)
    let (c,d) = split(y)
    
    let aXc = productOf(a, c)!
    let bXd = productOf(b, d)!
    let ad_bc = productOf((a + b), (c+d))! - bXd - aXc //Gauss's trick
    
    return (UInt64(pow(10, Double(length))) * aXc) + (UInt64(pow(10, Double(length / 2))) * ad_bc) + bXd
}

//Test1
productOf(987654321, 123456789)
