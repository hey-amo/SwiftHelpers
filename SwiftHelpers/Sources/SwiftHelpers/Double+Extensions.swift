//
//  Double+Extensions.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import Foundation

extension Double {
    func formattedCurrencyCompact(
        code: String = "USD",
        locale: Locale = Locale(identifier: "en_US")
    ) async -> String {
        // Use modern API if available (macOS 12+, iOS 15+)
        if #available(macOS 15, iOS 15, *) {
            return self.formatted(
                .currency(code: code)
                    .notation(.compactName)
                    .precision(.fractionLength(1))
                    .locale(locale)
            )
        } else {
            // Fallback for older systems
            let absValue = abs(self)
            let sign = self < 0 ? "-" : ""
            
            // Determine magnitude
            let (value, suffix): (Double, String) = {
                switch absValue {
                case 0..<1_000:
                    return (absValue, "")
                case 1_000..<1_000_000:
                    return (absValue / 1_000, "K")
                case 1_000_000..<1_000_000_000:
                    return (absValue / 1_000_000, "M")
                case 1_000_000_000..<1_000_000_000_000:
                    return (absValue / 1_000_000_000, "B")
                default:
                    return (absValue / 1_000_000_000_000, "T")
                }
            }()
            
            
            // Get cached formatter safely via actor
            let formatter = await NumberFormatterCache.shared.formatter(
                locale: locale,
                currencyCode: code,
                fractionDigits: 1
            )
            
            guard let formattedValue = formatter.string(from: NSNumber(value: value)) else {
                return "\(sign)\(self)"
            }
            
            return "\(sign)\(formattedValue)\(suffix)"
        }
    }
}
