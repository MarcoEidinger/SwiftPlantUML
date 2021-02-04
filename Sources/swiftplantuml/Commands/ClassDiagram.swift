import ArgumentParser
import Foundation
import SwiftPlantUMLFramework

enum ClassDiagramOutput: String, ExpressibleByArgument, CaseIterable {
    case browser
    case browserImageOnly
    case consoleOnly
}

extension SwiftPlantUML {
    struct ClassDiagram: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "classdiagram",
            abstract: "Generate PlantUML script and view it and diagram in browser",
            helpNames: [.short, .long]
        )

        @Argument(help: "List of paths to the files or directories containing swift sources")
        var paths = [String]()

        @Option(help: ArgumentHelp(
            "Defines output format. Options: \(ClassDiagramOutput.allCases.map(\.rawValue).joined(separator: ", "))",
            valueName: "format"
        )
        )
        var output: ClassDiagramOutput = .browser

        mutating func run() {
            var allPaths: [String]
            if !paths.isEmpty {
                allPaths = paths
            } else {
                allPaths = [] // Lint files in current working directory if no paths were specified.
            }

            switch output {
            case .browserImageOnly:
                ClassDiagramGenerator().generate(for: allPaths, presentedBy: PlantUMLBrowserPresenter(format: .imagePng))
            case .consoleOnly:
                ClassDiagramGenerator().generate(for: allPaths, presentedBy: PlantUMLConsolePresenter())
            default:
                ClassDiagramGenerator().generate(for: allPaths, presentedBy: PlantUMLBrowserPresenter(format: .default))
            }
        }
    }
}
