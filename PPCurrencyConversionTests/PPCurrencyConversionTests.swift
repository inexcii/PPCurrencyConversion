//
//  PPCurrencyConversionTests.swift
//  PPCurrencyConversionTests
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import XCTest
@testable import PPCurrencyConversion

class PPCurrencyConversionTests: XCTestCase {
    
    var ratesData = [String: Double]()

    override func setUp() {
        ratesData = load("dummy_rates.json")
    }
    override func tearDown() {
    }

    func testRateCalculator_CNY_USD() {
        guard let usdRate = ratesData["USD"], let cnyRate = ratesData["CNY"], cnyRate > 0 else {
            print("to-be-tested rate does not exist in data or invalid")
            return
        }
        
        let newRates = DataHandler.calculateRate(rates: ratesData, by: "CNY")
        XCTAssertEqual(newRates["USD"], DataHandler.roundDecimalPointToDigit(1e06, number: (usdRate / cnyRate)))
    }
    
    func testRateCalculator_CNY_JPY() {
        guard let jpyRate = ratesData["JPY"], let cnyRate = ratesData["CNY"], cnyRate > 0 else {
            print("to-be-tested rate does not exist in data or invalid")
            return
        }
        
        let newRates = DataHandler.calculateRate(rates: ratesData, by: "CNY")
        XCTAssertEqual(newRates["JPY"], DataHandler.roundDecimalPointToDigit(1e06, number: (jpyRate / cnyRate)))
    }
    
    fileprivate func load(_ filename: String) -> [String: Double] {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let json = jsonObject as? [String: Double] else {
                fatalError("json is not [String: Double] type")
            }
            return json.reduce([String: Double]()) {
                var result: [String: Double] = $0
                result[String($1.key.dropFirst(3))] = $1.value
                return result
            }
        } catch {
            fatalError("Couldn't parse \(filename) as \(error)")
        }
    }

}
