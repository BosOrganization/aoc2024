import Algorithms
import Foundation

struct Day02: AdventDay {
    let maxDistance = 3
    var data: String

    var entities: ([[Int]]) {
        let lines = data.lines
        var entities: [[Int]] = []
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let intLine = trimmedLine.splitInts()
            entities.append(intLine)
        }
        return entities
    }

    func part1() -> Any {
        entities.reduce(0, { $0 + (isIncreasing($1) == nil || isDecreasing($1) == nil ? 1 : 0) })
    }

    func part2() -> Any {
        var numberOfSafe = 0
        for entity in entities {
            if isDecreasing(entity) == nil || isIncreasing(entity) == nil {
                numberOfSafe += 1
                continue
            }
            for i in 0..<entity.count {
                var newEntity = entity
                newEntity.remove(at: i)
                if isDecreasing(newEntity) == nil || isIncreasing(newEntity) == nil {
                    numberOfSafe += 1
                    break
                }
            }
        }
        return numberOfSafe
    }

    func isIncreasing(_ numbers: [Int]) -> Int? {
        for i in 1..<numbers.count {
            if numbers[i] <= numbers[i-1] || abs(numbers[i] - numbers[i-1]) > maxDistance {
                return i
            }
        }
        return nil
    }

    func isDecreasing(_ numbers: [Int]) -> Int? {
        for i in 1..<numbers.count {
            if numbers[i] >= numbers[i-1] || abs(numbers[i] - numbers[i-1]) > maxDistance {
                return i
            }
        }
        return nil
    }
}
