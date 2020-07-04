//
//  CashFlow.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct CashFlow: Identifiable {
    public var id = UUID()
    
    public var date: Date
    public var type: CashFlowType
    public var amount: Double
    public var currency: Currency
    
    public init(
        date: Date,
        type: CashFlowType,
        amount: Double,
        currency: Currency
    ) {
        self.date = date
        self.type = type
        self.amount = amount
        self.currency = currency
    }
    
    public enum CashFlowType: Double {
        case inflow = 1.0
        case outflow = -1.0
    }
}

extension CashFlow {
    public func presentValue(rate: Double, present: Date = Date()) -> Double? {
        //  MARK: А ЧТО БУДЕТ ПРИ ОТРИЦАТЕЛЬНОЙ СТАВКЕ???
        //  guard rate >= 0 else { return nil }
        guard rate != 0 else { return amount * type.rawValue }
        
        
        let calendar = Calendar.autoupdatingCurrent
        let interval = calendar.dateComponents([.day], from: present, to: date)
        guard let intervalInDays = interval.day else { return nil }
        
        let years: Double = Double(intervalInDays) / 365
        let discount = 1 / pow(1 + rate, years)
        return amount * discount * type.rawValue
    }
    
    // MARK: testing only
    @available(iOS 13.0, *)
    fileprivate func pv(rate: Double, present: Date = Date()) -> Double? {
        let interval = present.distance(to: date) / (24 * 60 * 60)
        let years = interval / 365
        let discount = 1 / pow(1 + rate, years)
        return amount * discount * type.rawValue
    }
}
