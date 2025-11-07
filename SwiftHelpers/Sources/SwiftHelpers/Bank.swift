//
//  Bank.swift
//  SwiftHelpers
//
//  Created by Amarjit on 31/10/2025.
//


// Protocol for anything that can have a balance
public protocol Bankable {
    var balance: Int { get set }
    func updateBalance(_ amount: Int)
}

// Protocol defining bank operations
public protocol Banking {
    func credit(_ amount: Int, to account: Bankable) throws
    func debit(_ amount: Int, from account: Bankable) throws
    func getBalance(for account: Bankable) -> Int
}

// Concrete implementation
final public class Bank: Banking {
    public func credit(_ amount: Int, to account: Bankable) throws {
        do {
            let _ = try canCredit(amount)
        } catch let err {
            throw err
        }
        
        account.updateBalance(amount)
    }
    
    public func debit(_ amount: Int, from account: Bankable) throws {
        do {
            let _ = try canDebit(amount, from: account)
        } catch let err {
            throw err
        }
        
        account.updateBalance(-amount)
    }
    
    public func getBalance(for account: Bankable) -> Int {
        return account.balance
    }
    
    // MARK: Validate Funds, Credit and Debit
    
    public func hasEnoughFunds(for amount: Int, from account: Bankable) throws -> Bool {
        guard amount > 0 else {
            throw IntegerError.isNegativeValue(amount)
        }
        guard account.balance >= amount else {
            throw IntegerError.insufficentFunds
        }
        return true
    }
    
    public func canCredit(_ amount: Int) throws -> Bool {
        guard amount > 0 else {
            throw IntegerError.isNegativeValue(amount)
        }
        return true
    }
    
    public func canDebit(_ amount: Int, from account: Bankable) throws -> Bool {
        guard amount > 0 else {
            throw IntegerError.isNegativeValue(amount)
        }
        
        let sum = (account.balance - amount)
        
        guard sum >= 0 else {
            throw IntegerError.insufficentFunds
        }
        
        return true
    }
}
