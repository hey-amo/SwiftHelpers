//
//  Int+Extensions.swift
//  SwiftHelpers
//
//  Created by Amarjit on 20/10/2025.
//

import Foundation

public extension Int {
    var ordinalFormat: String? {
        let number: NSNumber = NSNumber(integerLiteral: self)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}
