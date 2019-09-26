//
//  ModelHandler.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

/// Handles model-UI related tasks
class ModelHandler {
    
    /// Returns the Currency models fetched from DB.
    /// The models are sorted by its `abbr` property
    static func getModels() -> [Currency] {
        var models = [Currency]()
        if let currencies = DBUtil.shared.readCurrencies() {
            for currency in currencies {
                let abbr = currency.value(forKey: "abbr") as? String ?? ""
                let name = currency.value(forKey: "name") as? String ?? ""
                let rate = currency.value(forKey: "rate") as? Double ?? 0.0
                models.append(Currency(name: name, abbr: abbr, rate: rate))
            }
        }
        return models.sorted(by: { $0.abbr < $1.abbr })
    }
}
