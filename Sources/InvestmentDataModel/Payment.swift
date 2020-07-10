//
//  Payment.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Payment: Identifiable, Equatable {
    public var id = UUID()
    public var date: Date
    public var amount: Double
    public var currency: Currency
    public var type: PaymentType
    public var sender: Entity
    public var recipient: Entity
    public var note: String
    
    public enum PaymentType: String {
        case investment = "Investment"
        case `return` = "Return"
    }
    
    public init(
        date: Date,
        amount: Double,
        currency: Currency,
        type: PaymentType,
        sender: Entity,
        recipient: Entity,
        note: String
    ) {
        self.date = date
        self.amount = amount
        self.currency = currency
        self.type = type
        self.sender = sender
        self.recipient = recipient
        self.note = note
    }
}
