//
//  SelectionView.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI

/// A view that allows user to enter the desired amount for selected currency
struct SelectionView: View {
    @EnvironmentObject var userData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    var currency: Currency
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 50) {
                HStack {
                    Spacer()
                    Text(currency.amount)
                        .lineLimit(1)
                        .font(.largeTitle)
                        .padding()
                        .minimumScaleFactor(0.01)
                }
                
                NumberpadView(currency: currency, rows: 4, columns: 3)
            }
            .navigationBarTitle("\(currency.abbr)")
            .navigationBarItems(trailing:
                Button(action: {
                    self.userData.updateRates(by: self.currency.abbr)
                    self.userData.setAmount(self.currency.amount)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Convert")
                })
            )
        }
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionView(currency: Currency(name: "test", abbr: "tst", rate: 1.0))
    }
}
