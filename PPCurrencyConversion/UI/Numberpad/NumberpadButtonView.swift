//
//  NumberpadButtonView.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import SwiftUI

enum ButtonType: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case point = "."
    case clear = "C"
}

struct NumberpadButtonView: View {
    @EnvironmentObject var userData: UserData
    @State var isError: Bool = false
    
    var type: ButtonType
    var geometry: GeometryProxy
    var rows: Int
    var columns: Int
    var currency: Currency
    
    var currencyIndex: Int {
        userData.currencies.firstIndex(where: { $0.id == currency.id })!
    }
    
    var body: some View {
        
        Button(action: {
            var amount = self.currency.amount
            switch self.type {
            case .clear:
                amount = "0"
            case .point:
                if amount.contains(".") {
                    self.isError = true
                } else if amount == "0" {
                    amount = "0."
                } else {
                    fallthrough
                }
            default:
                if amount == "0" {
                    amount = self.type.rawValue
                } else {
                    amount += self.type.rawValue
                }
            }
            self.userData.currencies[self.currencyIndex].amount = amount
        }, label: {
            Text(type.rawValue)
                .frame(minWidth: 0, idealWidth: self.geometry.size.width / CGFloat(columns), maxWidth: self.geometry.size.width,
                       minHeight: 0, idealHeight: self.geometry.size.height / CGFloat(rows), maxHeight: self.geometry.size.height, alignment: .center)
                .background(Color.gray)
                .foregroundColor(Color.yellow)
                .font(.title)
        }).alert(isPresented: self.$isError) { () -> Alert in
            // Alert for user inputing more than 1 point
            Alert(title: Text("Error"), message: Text("only one '.' is acceptable."), dismissButton: .default(Text("OK")))
        }
    }
}
