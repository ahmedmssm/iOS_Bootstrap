//
//  String + Nil if empty.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 3/17/19.
//

import Foundation

public extension Optional where Wrapped == String {
    public var nilIfEmpty: String? {
        guard let strongSelf = self else { return nil }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}
