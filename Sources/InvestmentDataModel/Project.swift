//
//  Project.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

struct Project: Identifiable {
    var id = UUID()
    
    var name: String
    var note: String
    
    var entities: [Entity]
    var transactions: [Transaction]
    
    var flows: [CashFlow] {
        transactions
            .compactMap { transaction in
                //  derive cash flow type from sender and recipient entities
                let isRecipient = entities.contains { $0 == transaction.recipient }
                let isSender = entities.contains { $0 == transaction.sender }
                
                let type: CashFlow.CashFlowType
                if isRecipient  {
                    type = .inflow
                } else if isSender {
                    type = .outflow
                } else {
                    print("error: \(name) is neither a sender or recipient in the transaction \(id)")
                    return nil
                }
                
                return CashFlow(date: transaction.date,
                                type: type,
                                amount: transaction.amount,
                                currency: transaction.currency)
            }
    }
    
    var totalInflows: Double {
        flows
            .filter { $0.type == .inflow }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var totalOutflows: Double {
        flows
            .filter { $0.type == .outflow }
            .map { $0.amount }
            .reduce(0, +)
    }
    
    var netFlows: Double { totalInflows - totalOutflows }
    
    func npv(rate: Double, present: Date = Date()) -> Double {
        flows
            .compactMap { $0.presentValue(rate:rate, present: present) }
            .reduce(0, +)
    }
}
