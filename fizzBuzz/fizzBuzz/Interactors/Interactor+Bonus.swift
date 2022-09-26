//
//  Interactor+Bonus.swift
//  FizzBuzz
//
//  Created by Mohamed Ali BELHADJ on 24/9/2022.
//

import Foundation

extension Interactor {
    /// This function invoke the fizz buzz algorithm using independent input parameters.
    ///
    /// ```
    /// invoke(range: 1...10,
    ///         applying: [
    ///         "Fizz": 2,
    ///         "Buzz": 3,
    ///         "FizzBuzz": 6])
    /// //["1", "Fizz", "Buzz", "Fizz", "5",
    /// //"FizzBuzz", "7", "Fizz", "Buzz", "Fizz"]
    /// ```
    ///
    /// - Warning: This function is an `async` one, its calls should be marked with `await`.
    /// - Parameter range: ClosedRange of integers
    /// - Parameter applying parameters: a dictionary of `String` as key and `Int` as value. The parameters specifying the word (ig. "Fizz") and the number to be replaced (eg. 3) respectivally.
    /// - Returns: An array of Strings by applying the fizz buzz algorithm for specified parameters.
    func invoke(range: ClosedRange<Int>, applying parameters: [String:Int]) async -> [String] {
        var result: [String] = []
        range.forEach { val in
            var tmp = ""
            parameters
                .lazy
                .sorted { $0.value < $1.value }
                .forEach { word, number in
                    if val.divisible(by: number) {
                        tmp = word
                    }
                }
            result.append(tmp.isEmpty ? String(val) : tmp)
        }
        return result
    }
}

extension Interactor {
    /// A representation of a closure taking an `Int` to return a `Bool` value.
    public typealias Predicate = (Int) -> Bool
    
    /// A representation of a dictionary of `String` as key and `Predicate` as value
    public typealias Trigger = [String : Predicate]
    
    /// A representation of an array of `Trigger`
    public typealias TriggerCollection = [Trigger]
    
    /// This function invoke the modified fizz buzz algorithm using independent input parameters and a collection of triggers.
    ///
    /// ```
    /// var fizzTrigger = Trigger()
    /// fizzTrigger["Fizz"] = { val in
    ///    val % 3 == 0
    ///}
    ///
    ///var buzzTrigger = Trigger()
    /// buzzTrigger["Buzz"] = { val in
    ///    val % 5 == 0
    /// }
    ///
    /// var fizzBuzzTrigger = Trigger()
    /// fizzBuzzTrigger["FizzBuzz"] = { val in
    ///     val == 7 || val == 2
    /// }
    ///
    /// invoke(range: 1...12, triggers: [fizzBuzzTrigger, fizzTrigger, buzzTrigger])
    ///
    /// //["1", "FizzBuzz", "Fizz", "4",
    /// // "Buzz", "Fizz", "FizzBuzz", "8",
    /// //"Fizz", "Buzz", "11", "Fizz"]
    ///
    /// ```
    ///
    /// - Warning: This function is an `async` one, its calls should be marked with `await`.
    /// - Warning: Use method createTrigger as a helper to simplify trigger creating.
    /// ```
    /// createTrigger(word: String, predicate: @escaping Predicate ) -> Trigger
    /// ```
    ///
    /// - Parameter range: ClosedRange of integers
    /// - Parameter triggers: containing the word to put when satisfying a given predicate.
    /// - Returns: An array of Strings by applying the modified fizz buzz algorithm for specified trigger.
    func invoke(range: ClosedRange<Int>, triggers: TriggerCollection) async -> [String] {
        var result: [String] = []
        range.forEach { val in
            var tmp = ""
            triggers.forEach { trigger in
                trigger.forEach { word, predicate in
                    if predicate(val) {
                        tmp = word
                    }
                }
            }
            result.append(tmp.isEmpty ? String(val) : tmp)
        }
        return result
    }
}
