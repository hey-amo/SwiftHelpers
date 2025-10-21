//
//  Bank.swift
//  SwiftHelpers
//
//  Created by Amarjit on 21/10/2025.
//

import Foundation

public enum BankError: Error, LocalizedError {
    case notEnoughCoins(required: Int, available: Int)
    case negativeValue(value: Int)
        
    public var errorDescription: String {
           switch self {
           case .negativeValue(let value):
               return "Numeric error: \(value) cannot be negative."
           case .notEnoughCoins(let required, let available):
               return "Not enough coins: required $\(required), available $\(available)."
           }
       }
}

public protocol BankTransaction {
    var balance: Int { get }
    mutating func credit(_ amount: Int)
    mutating func debit(_ amount: Int)
}

public struct Bank: BankTransaction {
    private var _balance: Int
    public var balance: Int {
        get { return self._balance }
    }
    
    init(_balance: Int) {
        self._balance = _balance
    }
    
    public mutating func credit(_ amount: Int) {
        guard canCredit(amount) else {
            return
        }
        self._balance += amount
    }
    
    public mutating func debit(_ amount: Int) {
        guard canDebit(amount) else {
            return
        }
        self._balance -= amount
    }
}

private extension Bank {
    private func canCredit(_ amount: Int) -> Bool {
        guard amount > 0 else { return false }
        return true
    }
    
    private func canDebit(_ amount: Int) -> Bool {
        guard amount > 0 else { return false }
        guard balance >= amount else { return false }
        
        // Check for a negative balance after subtraction
        let sum = (balance - amount)
        guard sum >= 0 else { return false }
        
        return true
    }
}
