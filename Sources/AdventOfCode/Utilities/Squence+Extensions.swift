//
//  Sequence+Additions.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/2/24.
//

import Foundation

extension Sequence where Element: AdditiveArithmetic {
    var sum: Element { reduce(into: .zero, +=) }
}

extension Sequence where Element: BinaryInteger {
    var product: Element { reduce(into: 1, *=) }
}

extension Sequence {
    func sum<Resolved: AdditiveArithmetic>(_ resolution: (Element) -> Resolved) -> Resolved {
        reduce(into: .zero) { $0 += resolution($1) }
    }
}

extension Sequence {
    func count(where predicate: (Element) -> Bool) -> Int {
        reduce(into: 0) { if predicate($1) { $0 += 1 } }
    }
}
