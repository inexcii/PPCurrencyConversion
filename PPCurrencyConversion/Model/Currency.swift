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
}

extension Currency: Identifiable {
    var id: String { abbr }
}
