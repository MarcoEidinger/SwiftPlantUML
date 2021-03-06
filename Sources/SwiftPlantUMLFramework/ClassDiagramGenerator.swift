import Foundation

/// UML Class Diagram powered by PlantUML
public struct ClassDiagramGenerator {
    private let fileCollector = FileCollector()

    /// default initializer
    public init() {}

    /// generate diagram from Swift file(s)
    /// - Parameters:
    ///   - paths: representing paths to Swift source code files on the file system
    ///   - configuration:  options to influence the generation and visual representation of the class diagram
    ///   - presenter: outputs the PlantUMLScript / Digram e.g. `PlantUMLBrowserPresenter` or `PlantUMLConsolePresenter`
    ///   - sdkPath: MacOSX SDK path used to handle type inference resolution
    public func generate(for paths: [String], with configuration: Configuration = .default, presentedBy presenter: PlantUMLPresenting = PlantUMLBrowserPresenter(), sdkPath: String? = nil) {
        let startDate = Date()
        outputDiagram(for: generateScript(for: fileCollector.getFiles(for: paths), with: configuration, sdkPath: sdkPath), with: presenter, processingStartDate: startDate)
    }

    /// generate diagram from a String containing Swift code
    /// - Parameters:
    ///   - content: representing a string containing Swift code
    ///   - presenter: outputs the PlantUMLScript / Digram e.g. `PlantUMLBrowserPresenter` or `PlantUMLConsolePresenter`
    public func generate(from content: String, with configuration: Configuration = .default, presentedBy presenter: PlantUMLPresenting = PlantUMLBrowserPresenter()) {
        let startDate = Date()
        outputDiagram(for: generateScript(for: content, with: configuration), with: presenter, processingStartDate: startDate)
    }

    func generateScript(for content: String, with configuration: Configuration = .default) -> PlantUMLScript {
        var allValidItems: [SyntaxStructure] = []

        if let validItems = SyntaxStructure.create(from: content)?.substructure {
            allValidItems.append(contentsOf: validItems)
        }
        return PlantUMLScript(items: allValidItems, configuration: configuration)
    }

    func generateScript(for files: [URL], with configuration: Configuration = .default, sdkPath: String? = nil) -> PlantUMLScript {
        var allValidItems: [SyntaxStructure] = []

        for aFile in files {
            if let validItems = SyntaxStructure.create(from: aFile, sdkPath: sdkPath)?.substructure {
                allValidItems.append(contentsOf: validItems)
            }
        }

        return PlantUMLScript(items: allValidItems, configuration: configuration)
    }

    func outputDiagram(for script: PlantUMLScript, with presenter: PlantUMLPresenting, processingStartDate date: Date) {
        logProcessingDuration(started: date)
        let semaphore = DispatchSemaphore(value: 0)
        presenter.present(script: script) {
            semaphore.signal()
        }
        semaphore.wait()
    }

    func logProcessingDuration(started processingStartDate: Date) {
        Logger.shared.info("Class diagram generated in \(Date().timeIntervalSince(processingStartDate)) seconds and will be presented now")
    }
}
