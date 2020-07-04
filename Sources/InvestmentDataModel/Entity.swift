//
//  Entity.swift
//  CashFlowStructTesting
//
//  Created by Igor Malyarov on 04.07.2020.
//

import Foundation

public struct Entity: Identifiable, Equatable {
    public var id = UUID()
    public var name: String
}
