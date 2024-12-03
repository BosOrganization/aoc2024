import Algorithms
import Foundation

struct Day01: AdventDay {
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
        var (left, right) = self.entities
        left.sort()
        right.sort()
        var differences = 0
        for (index, num) in left.enumerated() {
            let rightNum = right[index]
            differences += abs(num - rightNum)
        }
        return differences
    }

    func part2() -> Any {
        let (left, right) = self.entities
        // Group all the right items into their counts
        let rightGroupings = right.reduce(into: [:]) { counts, number in counts[number, default: 0] += 1 }
        var score = 0
        for leftNum in left {
            score += leftNum * rightGroupings[leftNum, default: 0]
        }
        return score
    }
}
