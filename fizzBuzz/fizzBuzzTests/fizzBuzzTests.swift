//
//  fizzBuzzTests.swift
//  fizzBuzzTests
//
//  Created by Mohamed Ali BELHADJ on 23/09/2022.
//

import XCTest
@testable import fizzBuzz

class fizzBuzzTests: XCTestCase {
    var interactor: Interactor? = nil
    
    
    override func tearDown() {
        interactor = nil
    }
    
    func testUtils() {
        let hugeRange = -1_000_000...1_000_000
        let result = Int.random(in: hugeRange).divisible(by: Int.random(in: hugeRange))
        
        XCTAssertEqual(10.divisible(by: 2), true)
        
        XCTAssertEqual(0.divisible(by: 0), false)
        XCTAssertEqual(Int.random(in: hugeRange).divisible(by: 0), false)
        
        XCTAssertNotEqual(result, nil)
    }
    
    func testBasicOutputUsingRandomIntegers() async {
        interactor = .init(limit: Int.random(in: 100...1_000), firstNumber: Int.random(in: 1...10), secondNumber: Int.random(in: 1...10), firstWord: "Fizz", secondWord: "Buzz")
        let result = await interactor?.invoke()
        
        XCTAssertEqual(result?.count, interactor?.limit)
    }
    
    func testInputEqualsOne() async {
        interactor = .init(limit: 1, firstNumber: 1, secondNumber: 1, firstWord: "Fizz", secondWord: "Buzz")
        let result = await interactor?.invoke()
        XCTAssertEqual(["FizzBuzz"], result)
    }
}
