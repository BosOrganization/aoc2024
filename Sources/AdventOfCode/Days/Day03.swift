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
        let firstRef = Reference(Int.self)
        let secondRef = Reference(Int.self)
        let regex = Regex {
            "mul("
            Capture(OneOrMore(.digit), as: firstRef) { item in
                Int(item)!
            }
            ","
            Capture(OneOrMore(.digit), as: secondRef) { item in
                Int(item)!
            }
            ")"
          }
          .anchorsMatchLineEndings()
        return data.matches(of: regex).reduce(into: 0) { partialResult, match in
            partialResult += match[firstRef] * match[secondRef]
        }
    }

    func part2() -> Any {
        let firstRef = Reference(Int.self)
        let secondRef = Reference(Int.self)
        let multiplyRegex = Regex {
            "mul("
            Capture(OneOrMore(.digit), as: firstRef) { item in
                Int(item)!
            }
            ","
            Capture(OneOrMore(.digit), as: secondRef) { item in
                Int(item)!
            }
            ")"
          }
          .anchorsMatchLineEndings()
        let multiplyInstructions = data.matches(of: multiplyRegex).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.multiply(match[firstRef], match[secondRef]), match.range))
        }

        let doRegex = Regex {
            "do()"
        }
        let doInstructions = data.matches(of: doRegex).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.doStuff, match.range))
        }

        let dontRegex = Regex {
            "don't()"
        }
        let dontInstructions = data.matches(of: dontRegex).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.dontDoStuff, match.range))
        }

        let allInstructions = multiplyInstructions + doInstructions + dontInstructions
        let sortedInstructions = allInstructions.sorted { $0.1.lowerBound < $1.1.lowerBound }

        var doStuff = true
        return sortedInstructions.reduce(into: 0) { partialResult, instruction in
            switch instruction.0 {
            case let .multiply(first, second):
                if doStuff {
                    partialResult += first * second
                }
            case .doStuff:
                doStuff = true
            case .dontDoStuff:
                doStuff = false
            }
        }
    }

    enum Instruction {
        case multiply(Int, Int)
        case doStuff
        case dontDoStuff
    }
}

