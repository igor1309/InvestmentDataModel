//
//  Project.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Project: Identifiable, Equatable {
    public var id = UUID()
    
    public var name: String
    public var note: String
    
    public var entities: [Entity]
    public var payments: [Payment]
    
    public init(
        name: String,
        note: String,
        entities: [Entity],
        payments: [Payment]
    ) {
        self.name = name
        self.note = note
        self.entities = entities
        self.payments = payments
    }
    
    public var flows: [CashFlow] {
        payments
            .compactMap { payment in
                //  derive cash flow type from sender and recipient entities
                let isRecipient = entities.contains { $0 == payment.recipient }
                let isSender = entities.contains { $0 == payment.sender }
                
                let type: CashFlow.CashFlowType
                if isRecipient  {
                    type = .inflow
                } else if isSender {
                    type = .outflow
                } else {
                    print("error: \(name) is neither a sender or recipient in the payment \(id)")
                    return nil
                }
                
                return CashFlow(date: payment.date,
                                type: type,
                                amount: payment.amount,
                                currency: payment.currency)
            }
    }
    
    public var totalInflows: Double {
        flows
            .filter { $0.type == .inflow }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    public var totalOutflows: Double {
        flows
            .filter { $0.type == .outflow }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    public var netFlows: Double { totalInflows - totalOutflows }
    
    public func npv(rate: Double, present: Date = Date()) -> Double {
        flows
            .compactMap { $0.presentValue(rate:rate, present: present) }
            .reduce(0, +)
    }
}

extension Project {
    public static func empty() -> Project {
        Project(name: "", note: "", entities: [], payments: [])
    }
}
