//
//  Currency.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

struct Currency {
    var name: String
    var abbr: String
    var rate: Double
    /// The amount that user inputs in the currency-selection view or displayed in the list as being converted by other selected currencies
    var amount: String = "0"
}

extension Currency: Identifiable {
    var id: String { abbr }
    var displayAmount: String {
        guard let amount = Double(amount) else {
            return "0"
        }
        print("\(abbr) based on amount: \(amount), rate: \(rate), display amount is: \(amount * rate)")
        return String(amount * rate)
    }
}
