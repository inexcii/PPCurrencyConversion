//
//  NumberpadView.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI

struct NumberpadView: View {
    @EnvironmentObject var userData: UserData
    
    var currency: Currency
    var rows: Int
    var columns: Int
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(alignment: .center, spacing: 10) {
                    // 7, 8, 9
                    HStack(alignment: .center, spacing: 10) {
                        NumberpadButtonView(type: .seven, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .eight, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .nine, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                    }
                    // 4, 5, 6
                    HStack(alignment: .center, spacing: 10) {
                        NumberpadButtonView(type: .four, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .five, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .six, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                    }
                    // 1, 2, 3
                    HStack(alignment: .center, spacing: 10) {
                        NumberpadButtonView(type: .one, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .two, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .three, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                    }
                    // C, 0, .
                    HStack(alignment: .center, spacing: 10) {
                        NumberpadButtonView(type: .clear, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .zero, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                        NumberpadButtonView(type: .point, geometry: geometry, rows: self.rows, columns: self.columns, currency: self.currency)
                    }
                }
            }
        }
    }
}

struct NumberpadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberpadView(currency: Currency(name: "test", abbr: "test", rate: 1.0), rows: 4, columns: 3)
    }
}
