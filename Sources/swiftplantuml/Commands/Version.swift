import ArgumentParser
import SwiftPlantUMLFramework

extension SwiftPlantUML {
    struct Version: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Display the current version of SwiftUML")

        static var value: String { SwiftPlantUMLFramework.Version.current.value }

        mutating func run() throws {
            print(Self.value)
        }
    }
}
