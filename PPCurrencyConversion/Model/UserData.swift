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
}

