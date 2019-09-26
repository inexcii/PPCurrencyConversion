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
    @State private var showModal = false
    @State private var index: Int?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.currencies) { currency in
                    CurrencyRowView(currency: currency)
                        .onTapGesture {
                            self.showModal.toggle()
                            self.index = self.userData.currencies.firstIndex(where: { $0.id == currency.id })!
                    }
                }
            }
            .navigationBarTitle(
                Text((self.index != nil) ? "Selected Currency: \(self.userData.currencies[self.index!].abbr)" : "Currency Conversion"),
                displayMode: .inline
            )
            .sheet(isPresented: $showModal, onDismiss: {
                print("selection view dismissed")
            }) {
                SelectionView(currency: self.userData.currencies[self.index ?? 0])
                    .environmentObject(self.userData)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
