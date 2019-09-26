//
//  UserData.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var currencies: [Currency]
    
    init(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func updateRates(by abbr: String) {
        let newRates = DataHandler.calculateRate(rates: DataHandler.getRatesFromDB(),
                                                 by: abbr)
        for currency in currencies {
            let index = currencies.firstIndex(where: { $0.id == currency.id })!
            currencies[index].rate = newRates[currency.abbr] ?? 0.0
        }
    }
    
    func setAmount(_ amount: String) {
        for currency in currencies {
            let index = currencies.firstIndex(where: { $0.id == currency.id })!
            currencies[index].amount = amount
        }
    }
}

