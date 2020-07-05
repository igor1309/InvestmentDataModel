//
//  Entity.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Entity: Identifiable, Equatable, Hashable {
    public var id = UUID()
    public var name: String
    
    public init(_ name: String) {
        self.name = name
    }
}
