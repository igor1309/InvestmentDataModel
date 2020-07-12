//
//  Project.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Project: Identifiable, Equatable, Codable {
    public var id = UUID()
    
    public var name: String
    public var note: String
    
    public var currency: Currency
    
    public var entities: [Entity]
    public var payments: [Payment]
    
    public init(
        name: String,
        note: String,
        currency: Currency,
        entities: [Entity],
        payments: [Payment]
    ) {
        self.name = name
        self.note = note
        self.currency = currency
        self.entities = entities
        self.payments = payments
    }
    
    public var flows: [CashFlow] {
        payments
            .compactMap { payment in
                let type: CashFlow.CashFlowType
                switch payment.type {
                case .investment:
                    type = .inflow
                case .return:
                    type = .outflow
                }
                
                return CashFlow(
                    date: payment.date,
                    type: type,
                    amount: payment.amount
                )
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
