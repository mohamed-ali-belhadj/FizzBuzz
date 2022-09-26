//
//  Interactor.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 23/9/2022.
//

import Foundation

public protocol InteractorProtocol {
    func invoke() async -> [String]
}

public class Interactor {
    let limit: Int
    let firstNumber: Int 
    let secondNumber: Int 
    let firstWord: String 
    let secondWord: String
    
    init(limit: Int, firstNumber: Int, secondNumber: Int, firstWord: String, secondWord: String) {
        self.limit = limit
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
        self.firstWord = firstWord
        self.secondWord = secondWord
    }
    
    /// This function returns an array of integers for a given `limit`.
    ///
    /// ```
    /// print(buildRangedArray(to: 5))
    /// // [1, 2, 3, 4, 5]
    /// ```
    ///
    /// - Parameter limit: The limit to reach when filling the array of integers.
    /// - Returns: An array of integers.
    public func buildRangedArray(to limit: Int) -> [Int] {
        var array: Array<Int> = []
        array.reserveCapacity(limit)
        array = Array(1...limit)
        return array
    }
    
    public func createTrigger(word: String, predicate: @escaping Predicate ) -> Trigger {
        var trigger = Trigger()
        trigger[word] = predicate
        return trigger
    }
}

extension Interactor: InteractorProtocol {
    /// This function invoke the fizz buzz algorithm using the Interactor attached parameters.
    ///
    /// ```
    /// let limit = 10
    /// let str1 = "fizz"
    /// let str2 = "buzz"
    /// let int1 = 3
    /// let int2 = 5
    /// interactor.invoke()
    /// // ["1", "2", "fizz", "4", "buzz",
    /// // "fizz", "7", "8", "fizz", "buzz"]
    /// ```
    ///
    /// - Warning: This function is an `async` one, its calls should be marked with `await`.
    /// - Returns: An array of Strings by applying the fizz buzz algorithm.
    public func invoke() async -> [String] {
        var finalResult: [String] = []
        buildRangedArray(to: limit)
            .lazy
            .forEach { val in
                let FIRST_TEST = val.divisible(by: firstNumber)
                let SECOND_TEST = val.divisible(by: secondNumber)
                if FIRST_TEST && SECOND_TEST {
                    finalResult.append(firstWord+secondWord)
                } else if FIRST_TEST {
                    finalResult.append(firstWord)
                } else if SECOND_TEST {
                    finalResult.append(secondWord)
                } else {
                    finalResult.append(String(val))
                }
            }
        return finalResult
    }
}

extension Int {
    /// This function returns a boolean indicating whether an integer is divisible by a `denominator` or not.
    ///
    /// ```
    /// 10.divisible(by: 5) // true
    /// 10.divisible(by: 3) // false
    /// ```
    ///
    /// - Parameter by denominator: The integer to apply modulo on.
    /// - Returns: Boolean indicating the result discussed.
    func divisible(by denominator: Int) -> Bool {
        guard denominator != 0 else { return false }
        return self % denominator == 0
    }
}
