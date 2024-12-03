//
//  Day3.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/2/24.
//

import Algorithms
import Foundation
import RegexBuilder

struct Day03: AdventDay {
    var data: String

    func part1() -> Any {
        let firstRef = Reference(Substring.self)
        let secondRef = Reference(Substring.self)
        let regex = Regex {
            "mul("
            Capture(as: firstRef) {
                OneOrMore(.digit)
            }
            ","
            Capture(as: secondRef) {
                OneOrMore(.digit)
            }
            ")"
          }
          .anchorsMatchLineEndings()
        var result = 0
        for item in data.matches(of: regex) {
            let first = Int(item[firstRef])!
            let second = Int(item[secondRef])!
            guard abs(first) < 1000, abs(second) < 1000 else { continue }
            result += first * second
        }
        return result
    }

    func part2() -> Any {
        let firstRef = Reference(Substring.self)
        let secondRef = Reference(Substring.self)
        let regexMultiply = Regex {
            "mul("
            Capture(as: firstRef) {
                OneOrMore(.digit)
            }
            ","
            Capture(as: secondRef) {
                OneOrMore(.digit)
            }
            ")"
          }
          .anchorsMatchLineEndings()
        var result = 0
        var instructions: [(Instruction, Range<String.Index>)] = []
        for item in data.matches(of: regexMultiply) {
            let first = Int(item[firstRef])!
            let second = Int(item[secondRef])!
            guard abs(first) < 1000, abs(second) < 1000 else { continue }
            instructions.append((.multiply(first, second), item.range))
        }

        let doRegex = Regex {
            "do()"
        }
        for item in data.matches(of: doRegex) {
            instructions.append((.doStuff, item.range))
        }

        let dontRegex = Regex {
            "don't()"
        }
        for item in data.matches(of: dontRegex) {
            instructions.append((.dontDoStuff, item.range))
        }

        let sortedInstructions = instructions.sorted { $0.1.lowerBound < $1.1.lowerBound }

        var doStuff = true
        for instruction in sortedInstructions {
            switch instruction.0 {
            case let .multiply(first, second):
                if doStuff {
                    result += first * second
                }
            case .doStuff:
                doStuff = true
            case .dontDoStuff:
                doStuff = false
            }
        }

        return result
    }

    enum Instruction {
        case multiply(Int, Int)
        case doStuff
        case dontDoStuff
    }
}

