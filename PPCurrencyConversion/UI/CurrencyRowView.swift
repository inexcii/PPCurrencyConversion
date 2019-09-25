//
//  CurrencyRow.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI

struct CurrencyRowView: View {
    var currency: Currency
    
    var body: some View {
        HStack {
            Text(currency.abbr)
            Text(":")
            Text(currency.name)
            Spacer()
            Text(currency.amount)
                .lineLimit(3)
                .minimumScaleFactor(0.01)
        }
    }
}

struct CurrencyRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(currency: Currency(name: "test", abbr: "tst", rate: 1.0))
    }
}
