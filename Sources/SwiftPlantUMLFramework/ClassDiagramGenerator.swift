import Foundation

/// UML Class Diagram powered by PlantUML
public struct ClassDiagramGenerator {
    /// default initializer
    public init() {}

    /// generate diagram
    public func generate(for paths: [String], presentedBy presenter: PlantUMLPresenting = PlantUMLBrowserPresenter()) {
        outputDiagram(for: generateScript(for: getFiles(for: paths)), with: presenter)
    }

    func getFiles(for paths: [String]) -> [URL] {
        var singleInputURL: URL?

        if paths.isEmpty {
            singleInputURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        } else if paths.count == 1, paths[0] == "." {
            singleInputURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        } else {
            return paths.map { URL(fileURLWithPath: $0) }
        }

        guard let url = singleInputURL else { return [] }
        let isDirectory = (try? url.resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory ?? false
        if isDirectory {
            var files = [URL]()
            if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
                for case let fileURL as URL in enumerator {
                    do {
                        let fileAttributes = try fileURL.resourceValues(forKeys: [.isRegularFileKey, .typeIdentifierKey])
                        if fileAttributes.isRegularFile!, fileAttributes.typeIdentifier == "public.swift-source" {
                            files.append(fileURL)
                        }
                    } catch { print(error, fileURL) }
                }
            }
            return files
        } else {
            return [url]
        }
    }

    func generateScript(for files: [URL]) -> PlantUMLScript {
        var allValidItems: [SyntaxStructure] = []

        for aFile in files {
            if let validItems = SyntaxStructure.create(from: aFile)?.substructure {
                allValidItems.append(contentsOf: validItems)
            }
        }

        return PlantUMLScript(items: allValidItems)
    }

    func outputDiagram(for script: PlantUMLScript, with presenter: PlantUMLPresenting) {
        let semaphore = DispatchSemaphore(value: 0)
        presenter.present(script: script) {
            semaphore.signal()
        }
        semaphore.wait()
    }
}
