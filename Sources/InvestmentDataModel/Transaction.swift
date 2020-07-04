//
//  Transaction.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

struct Transaction: Identifiable {
    var id = UUID()
    var date: Date
    var amount: Double
    var currency: Currency
    var sender: Entity
    var recipient: Entity
    var note: String
}
