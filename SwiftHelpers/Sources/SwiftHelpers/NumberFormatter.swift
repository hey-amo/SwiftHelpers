//
//  NumberFormatter.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import Foundation

// Thread-safe, no need for locks.
// Avoids race conditions if formatters are accessed from multiple threads.
//
actor NumberFormatterCache {
    static let shared = NumberFormatterCache()
    private var cache: [String: NumberFormatter] = [:]
    
    func formatter(locale: Locale, currencyCode: String, fractionDigits: Int = 1) -> NumberFormatter {
        let key = "\(locale.identifier)_\(currencyCode)_\(fractionDigits)"
        if let existing = cache[key] {
            return existing
        }
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = fractionDigits
        formatter.minimumFractionDigits = 0
        formatter.roundingMode = .halfUp
        
        cache[key] = formatter
        return formatter
    }
    
    func ordinalFormatter(locale: Locale = Locale(identifier: "en_US")) -> NumberFormatter {
        let key = "ordinal_\(locale.identifier)"
        if let existing = cache[key] { return existing }
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .ordinal
        formatter.maximumFractionDigits = 0
        formatter.allowsFloats = false
        formatter.roundingMode = .ceiling
        formatter.alwaysShowsDecimalSeparator = false
        
        cache[key] = formatter
        return formatter
    }
}
