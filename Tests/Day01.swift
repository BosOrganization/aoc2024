import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day01Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """

    func testPart1() throws {
        let challenge = Day01(data: testData)
        let answer = String(describing: challenge.part1())
        print("1️⃣ \(answer)")
        XCTAssertEqual(answer, "6000")
    }

    func testPart2() throws {
        let challenge = Day01(data: testData)
        let answer = String(describing: challenge.part2())
        print("2️⃣ \(answer)")
        XCTAssertEqual(answer, "32000")
    }
}
