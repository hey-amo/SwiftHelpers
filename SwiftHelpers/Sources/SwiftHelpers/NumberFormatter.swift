//
//  NumberFormatter.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import Foundation

struct NumberFormatCache {
    static let currencyRateFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.allowsFloats = false
        formatter.roundingMode = .ceiling
        formatter.alwaysShowsDecimalSeparator = false
        return formatter
    }()

    static let ordinalFormat: NumberFormatter = {
        let format = NumberFormatter()
        format.locale = Locale(identifier: "en_US")
        format.numberStyle = .ordinal
        format.maximumFractionDigits = 0
        format.allowsFloats = false
        format.roundingMode = .ceiling
        format.alwaysShowsDecimalSeparator = false
        return format
    }()
}

func cashFormat(amount: Int) -> String {
    let number: NSNumber = NSNumber(integerLiteral: amount)
    let cache = NumberFormatCache.currencyRateFormatter
    return cache.string(from: number) ?? "$0"
}
