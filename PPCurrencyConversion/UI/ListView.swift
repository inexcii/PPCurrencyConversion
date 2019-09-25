//
//  ListView.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.currencies) { currency in
                    CurrencyRowView(currency: currency)
                        .onTapGesture {
                            // TODO: tap action
                    }
                }
            }
        .navigationBarTitle(Text("Currency Conversion"))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
