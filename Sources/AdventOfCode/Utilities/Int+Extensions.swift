//
//  Int+Extensions.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/2/24.
//

import Foundation

extension Int {
    func lcm(_ other: Int) -> Int {
        self * (other / self.gcd(other))
    }

    func gcd(_ other: Int) -> Int {
        var a = abs(self)
        var b = abs(other)
        if b > a {
            (b, a) = (a, b)
        }
        while b != 0 {
            (a, b) = (b, a % b)
        }
        return a
    }
}
