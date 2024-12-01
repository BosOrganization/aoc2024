import Algorithms
import Foundation

struct Day02: AdventDay {
    var data: String

    var entities: ([Int],[Int]) {
        let lines = data.split(separator: "\n").compactMap { String($0) }
        var left: [Int] = []
        var right: [Int] = []
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let splitLint = trimmedLine.split(separator: " ").map({ String($0) })
            left.append(Int(splitLint[0])!)
            right.append(Int(splitLint[1])!)
        }
        return (left, right)
    }

    func part1() -> Any {
        0
    }

    func part2() -> Any {
        0
    }
}
