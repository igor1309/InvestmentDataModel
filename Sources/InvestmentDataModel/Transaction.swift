//
//  Transaction.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Transaction: Identifiable {
    public var id = UUID()
    public var date: Date
    public var amount: Double
    public var currency: Currency
    public var sender: Entity
    public var recipient: Entity
    public var note: String
}
