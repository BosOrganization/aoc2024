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

    private let firstMul = Reference(Int.self)
    private let secondMul = Reference(Int.self)

    private var mulRegEx: some RegexComponent {
        Regex {
            "mul("
            Capture(OneOrMore(.digit), as: firstMul) { item in
                Int(item)!
            }
            ","
            Capture(OneOrMore(.digit), as: secondMul) { item in
                Int(item)!
            }
            ")"
          }
          .anchorsMatchLineEndings()
    }

    private var doRegex: some RegexComponent {
        Regex {
            "do()"
        }
        .anchorsMatchLineEndings()
    }

    private var dontRegex: some RegexComponent {
        Regex {
            "don't()"
        }
        .anchorsMatchLineEndings()
    }

    func part1() -> Any {
        return data.matches(of: mulRegEx).reduce(into: 0) { partialResult, match in
            partialResult += match[firstMul] * match[secondMul]
        }
    }

    func part2() -> Any {
        // Grab all of the instructions
        let multiplyInstructions = data.matches(of: mulRegEx).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.multiply(match[firstMul], match[secondMul]), match.range))
        }

        let doInstructions = data.matches(of: doRegex).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.doStuff, match.range))
        }

        let dontInstructions = data.matches(of: dontRegex).reduce(into: [(Instruction, Range<String.Index>)]()) { partialResult, match in
            partialResult.append((.dontDoStuff, match.range))
        }

        let allInstructions = multiplyInstructions + doInstructions + dontInstructions
        // Order the instructions by where they start
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

