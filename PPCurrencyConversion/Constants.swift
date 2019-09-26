//
//  Constants.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import Foundation

struct Constants {
    static let ApiName = "http://apilayer.net/api/list?access_key=8fa73230006a78d751e0cba30fac5837&format=1"
    static let ApiRate = "http://apilayer.net/api/live?access_key=8fa73230006a78d751e0cba30fac5837&format=1"
    
    /// x-digit after decimal point to be rounded when calculating the user-selected currency
    static let roundDigit = 1e05
}
