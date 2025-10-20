//
//  NumberFormatterTests.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import XCTest

@testable import SwiftHelpers

final class NumberFormatterTests: XCTestCase {
    
    func testBigNumberFormat() throws {
        let num: Double = 1_250_000
        let formatted = num.formatted(.number.notation(.compactName).precision(.fractionLength(1)))
        print(formatted)  // “1.1M” in en locale
    }
    
    func testBigCurrencyNumberFormat() throws {
        Task {
            let value: Double = 1_250_000
            print(await value.formattedCurrencyCompact()) // "$1.2M"
        }

    }
    
    func testOrdinalNumberFormat() throws {
        Task {
            let ordinalFormatter = await NumberFormatterCache.shared.ordinalFormatter(locale: Locale(identifier: "en_US"))
            print(ordinalFormatter.string(from: 1)!) // "1st"
        }
    }
    
}
