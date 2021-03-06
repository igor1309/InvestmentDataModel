//
//  Currency.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

public enum Currency: String, Codable, CaseIterable {
    case rub, usd, euro
    
    public var symbol: String {
        switch self {
        case .euro:
            return "€"
        case .usd:
            return "$"
        case .rub:
            return "₽"
        }
    }
}
