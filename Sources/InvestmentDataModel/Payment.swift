//
//  Payment.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Payment: Identifiable, Equatable, Codable {
    public var id = UUID()
    public var date: Date
    public var amount: Double
    public var type: PaymentType
    public var senderID: UUID
    public var recipientID: UUID
    public var note: String
    
    public enum PaymentType: String, CaseIterable, Codable {
        case investment, `return`
        
        public var id: String { rawValue.capitalized }
    }
    
    public init(
        date: Date,
        amount: Double,
        type: PaymentType,
        senderID: UUID,
        recipientID: UUID,
        note: String
    ) {
        self.date = date
        self.amount = amount
        self.type = type
        self.senderID = senderID
        self.recipientID = recipientID
        self.note = note
    }
}
