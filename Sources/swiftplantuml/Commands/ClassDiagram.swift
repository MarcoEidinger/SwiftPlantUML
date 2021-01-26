import ArgumentParser
import Foundation
import SwiftPlantUMLFramework

extension SwiftPlantUML {
    struct ClassDiagram: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "classdiagram",
            abstract: "Generate PlantUML script and view diagram in browser"
        )

        @Argument(help: "List of paths to the files or directories containing swift sources")
        var paths = [String]()

        @Flag(help: "Print PlantUML script (without launching the browser)")
        var textonly = false

        mutating func run() {
            var allPaths: [String]
            if !paths.isEmpty {
                allPaths = paths
            } else {
                allPaths = [] // Lint files in current working directory if no paths were specified.
            }

            if textonly == true {
                ClassDiagramGenerator().generate(for: allPaths, presentedBy: PlantUMLConsolePresenter())
            } else {
                ClassDiagramGenerator().generate(for: allPaths)
            }
        }
    }
}
