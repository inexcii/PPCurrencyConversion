//
//  DataHandler.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

/// Handles data, or data-model related tasks
class DataHandler {
     
    static func getRatesFromDB() -> [String: Double] {
        var rates = [String: Double]()
        
        if let currencies = DBUtil.shared.readCurrencies() {
            for currency in currencies {
                let abbr = currency.value(forKey: "abbr") as? String ?? ""
                let rate = currency.value(forKey: "rate") as? Double ?? 0.0
                rates[abbr] = rate
            }
        }
        
        return rates
    }
    
    /// Calculate rates based on user-selected currency
    /// - Parameter rates: The rates that is fetched from API as a referrence
    /// - Parameter currency: The `abbr` of user-selected currency that is intented to be calculated
    /// - Returns: A new rates dictionary whose rates are calculated based on the selected currency
    static func calculateRate(rates: [String: Double], by currency: String) -> [String: Double] {
        var calculatedRates = [String: Double]()
        
        if let refRate = rates[currency], refRate > 0.0 {
            calculatedRates = rates.reduce([String: Double]()) {
                var result: [String: Double] = $0
                let num = $1.value / refRate
                result[$1.key] = roundDecimalPointToDigit(1e06, number: num)
                return result
            }
        } else {
            print("failed to calculate rates because reference rate does not exist or <= 0.0")
        }
        
        return calculatedRates
    }
    
    /// Round a number(Double) to  x-digit decimal point
    /// - Parameter digit: The decimal point digit to be reserved
    /// - Parameter number: The number to be rounded to x-digit decimal point
    /// - Returns: rounded number
    static func roundDecimalPointToDigit(_ digit: Double, number: Double) -> Double {
        return round(number * digit) / digit
    }
    static func roundDecimalPointToDigit(_ digit: Double, number: String) -> String {
        if let number = Double(number) {
            return String(roundDecimalPointToDigit(digit, number: number))
        } else {
            return "0"
        }
    }
}
