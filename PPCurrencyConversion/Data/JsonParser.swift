//
//  JsonParser.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

/// A class for parsing JSON
class JsonParser {
    func parseName(data: Data) -> [String: String] {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let json = jsonObject as? [String: Any],
                  let namesDic = json["currencies"] as? [String: String]
                else {
                fatalError("jsonObject is not [String: Any] type, or json has no 'currencies' key or its value is not [String: String] type")
            }
            
            return namesDic
        } catch {
            fatalError("Couldn't parse name data: \(data) due to \(error)")
        }
    }
    
    func parseRates(data: Data) -> [String: Double] {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard let json = jsonObject as? [String: Any],
                  let ratesDic = json["quotes"] as? [String: Double]
                else {
                fatalError("jsonObject is not [String: Any] type, or json has no 'quotes' key or its value is not [String: Double] type")
            }
            
            return ratesDic.reduce([String: Double]()) {
                var result: [String: Double] = $0
                // e.g. 'USDAED' -> 'AED'
                result[String($1.key.dropFirst(3))] = $1.value
                return result
            }
        } catch {
            fatalError("Couldn't parse rates data: \(data) due to \(error)")
        }
    }
}
