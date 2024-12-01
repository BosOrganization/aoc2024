//
//  File.swift
//  AdventOfCode
//
//  Created by Bo Oelkers on 12/1/24.
//

import Foundation
import PackagePlugin
import RegexBuilder

@main
struct DatabaseBump: CommandPlugin {
    func performCommand(context: PluginContext, arguments: [String]) async throws {
        // Uncomment this debugging. This plugin runs so fast that the debugger cant attach to it fast enough 😂
//        sleep(2)
        let dataFolder = context.package.directoryURL.appending(path: "Sources/Data")
        let daysFolder = context.package.directoryURL.appending(path: "Sources/Days")
        let fileManager = FileManager.default

        let dataDir = try fileManager.contentsOfDirectory(atPath: dataFolder.path())

        let nextDayItems = dataDir
            .filter({ $0.hasPrefix("Day") })
            .map({ String($0.dropFirst("Day".count)) })
            .map({ String($0.dropLast(".txt".count)) })
        let nextDay = nextDayItems.compactMap({ Int($0) })
            .max()! + 1

        let currentDayData = dataFolder.appending(path: "Day\(nextDay < 10 ? "0" : "")\(nextDay - 1).txt")
        let nextDayData = dataFolder.appending(path: "Day\(nextDay < 10 ? "0" : "")\(nextDay).txt")

        let currentDayCode = daysFolder.appending(path: "Day\(nextDay < 10 ? "0" : "")\(nextDay - 1).swift")
        let nextDayCode = daysFolder.appending(path: "Day\(nextDay < 10 ? "0" : "")\(nextDay).swift")

        // Copies over the current day data
        try fileManager.copyItem(at: currentDayData, to: nextDayData)
        try fileManager.copyItem(at: currentDayCode, to: nextDayCode)
    }
}


