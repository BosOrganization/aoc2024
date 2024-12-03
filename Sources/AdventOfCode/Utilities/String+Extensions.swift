//
//  String+Extensions.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/2/24.
//

import Foundation

extension StringProtocol {
    func splitInts(separator: Character = " ") -> [Int] {
        self.split(separator: separator).compactMap { Int($0) }
    }
}

extension String {
    var lines: [Substring] { split(separator: "\n") }
}

extension LazyCollection<String> {
    var lines: some Sequence<Substring> { split(separator: "\n") }
}

extension Range where Bound: Strideable {
    static func + (lhs: Self, rhs: Bound.Stride) -> Self {
        lhs.lowerBound.advanced(by: rhs)..<lhs.upperBound.advanced(by: rhs)
    }
}
