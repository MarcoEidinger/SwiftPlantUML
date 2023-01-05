import ArgumentParser
import Foundation
import SwiftPlantUMLFramework
import Yams

extension SwiftPlantUML {
    struct ClassDiagram: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "classdiagram",
            abstract: "Generate PlantUML script and view it and diagram in browser",
            helpNames: [.short, .long]
        )

        @Option(help: "Path to custom configuration filed (otherwise will search for `.swiftplantuml.yml` in current directory)")
        var config: String?

        @Option(help: "paths to ignore source files. Takes precedence over arguments")
        var exclude = [String]()

        @Option(help: ArgumentHelp(
            "Defines output format. Options: \(ClassDiagramOutput.allCases.map(\.rawValue).joined(separator: ", "))",
            valueName: "format"
        ))
        var output: ClassDiagramOutput?

        @Option(help: "MacOSX SDK path used to handle type inference resolution, usually `$(xcrun --show-sdk-path -sdk macosx)`")
        var sdk: String?

        @Flag(help: "Decide if/how Swift extensions shall be considered for class diagram generation")
        var extensionVisualization: ExtensionVisualization = .showExtensions

        @Flag(help: "Verbose")
        var verbose: Bool = false

        @Argument(help: "List of paths to the files or directories containing swift sources")
        var paths = [String]()

        mutating func run() {
            Logger.shared = BeaverLogger.create(verbose: verbose, classDiagramOutput: output)

            var allPaths: [String]
            if !paths.isEmpty {
                allPaths = paths
            } else {
                allPaths = [] // Lint files in current working directory if no paths were specified.
            }

            var config = ConfigurationProvider().getConfiguration(for: self.config)

            if !exclude.isEmpty {
                config.files.exclude = exclude
            }

            if config.elements.extensions == nil {
                switch extensionVisualization {
                case .hideExtensions:
                    config.elements.extensions = SwiftPlantUMLFramework.ExtensionVisualization.none
                case .mergeExtensions:
                    config.elements.extensions = .merged
                case .showExtensions:
                    config.elements.extensions = .all
                }
            }

            Logger.shared.info("SDK: \(sdk ?? "no SDK path provided")")

            let directory = FileManager.default.currentDirectoryPath // "/Users/d041771/git/__Private/SwiftPlantUML"
            let files = FileCollector().getFiles(for: allPaths, in: directory, honoring: config.files)

            let generator = ClassDiagramGenerator()

            switch output {
            case .browserImageOnly:
                generator.generate(for: files.map(\.path), with: config, presentedBy: PlantUMLBrowserPresenter(format: .imagePng), sdkPath: sdk)
            case .consoleOnly:
                generator.generate(for: files.map(\.path), with: config, presentedBy: PlantUMLConsolePresenter(), sdkPath: sdk)
            default:
                generator.generate(for: files.map(\.path), with: config, presentedBy: PlantUMLBrowserPresenter(format: .default), sdkPath: sdk)
            }
        }
    }
}

extension ClassDiagramOutput: ExpressibleByArgument {}

enum ExtensionVisualization: EnumerableFlag {
    case hideExtensions
    case mergeExtensions
    case showExtensions
}
