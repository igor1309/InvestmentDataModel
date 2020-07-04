//
//  Currency.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

public enum Currency: String {
    case rub, usd, euro
    
    var symbol: String {
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
