//
//  File.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/1/24.
//

import ArgumentParser
import Foundation

let siteURL = URL(string: "https://adventofcode.com/2024/")!

func url(day: Int) -> URL {
    siteURL.appending(components: "day", "\(day)", "input")
}

func input(day: Int, for session: String? = nil) async throws -> Data {
    precondition(day > 0 && day <= 25, "Day is Out of Bounds")

    // Basically assume we need to set the cookie every time
    try setCookie(session: session)

    let url = url(day: day)
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

    let (bytes, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw URLError(
            .badServerResponse,
            userInfo: [
                "ResponseCode": (response as? HTTPURLResponse)?.statusCode as Any,
                NSLocalizedDescriptionKey: String(bytes: bytes, encoding: .utf8) as Any,
            ]
        )
    }

    return bytes
}

func setCookie(session: String?) throws {
    let sessionID: String
    if let session {
        sessionID = session.trimmingCharacters(in: .whitespacesAndNewlines)
    } else {
        let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
        let sessionURL = homeDirURL.appending(component: ".adventofcode_session")
        let rawID = try String(contentsOf: sessionURL, encoding: .utf8)
        sessionID = rawID.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    let cookie = HTTPCookie(
        properties: [
            .domain: ".adventofcode.com",
            .path: "/",
            .secure: "true",
            .name: "session",
            .value: sessionID,
        ]
    )!

    HTTPCookieStorage.shared.setCookie(cookie)
}

func bytes(_ day: Int) async throws -> [UInt8] {
    Array(try await input(day: day))
}

func string(_ day: Int) async throws -> String {
    String(bytes: try await input(day: day), encoding: .utf8) ?? ""
}

@main
struct AdventOfCode: AsyncParsableCommand {
    @Argument(help: "The day of the challenge. For December 1st, use '1'.")
    var day: Int?

    func run() async throws {
        let day: Int
        if let d = self.day {
            day = d
        } else {
            var currentCalendar = Calendar.current
            currentCalendar.timeZone = TimeZone(abbreviation: "EST")!
            let components = currentCalendar.dateComponents([.day], from: .now)
            day = components.day!
        }
        let data = try await input(day: day)
        let dir = String(format: "/Users/booelkers/Documents/aoc2024/Sources/AdventOfCode/Data/Day%02d.txt", arguments: [day])
        if !FileManager.default.fileExists(atPath: dir) {
            FileManager.default.createFile(atPath: dir, contents: nil)
        }
        try data.write(to: .init(filePath: dir))
    }
}
