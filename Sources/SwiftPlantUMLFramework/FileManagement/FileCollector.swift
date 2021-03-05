import Foundation

/// Collect file paths based on a set of constraints
public struct FileCollector {
    /// default initializer
    public init() {}

    /// get file urls for given constraints
    /// - Parameters:
    ///   - paths: array of file paths or just use `["."]`
    ///   - directory: root of recursive search
    ///   - fileOptions: containing include/exclude information via Globs
    /// - Returns: an array of URLs
    public func getFiles(for paths: [String], in directory: String, honoring fileOptions: FileOptions?) -> [URL] {
        var included: [Glob] = []
        var excluded: [Glob] = []

        var searchPaths: [String] = paths
        var files: [URL] = []
        var filesNotExcluded: [URL] = []

        if let include = fileOptions?.include, !include.isEmpty {
            searchPaths = ["."]
            Logger.shared.info("paths will be ignored in favor of configuration (files:include: \(include.joined(separator: ", ")))")
        }

        let allFiles = getFiles(for: searchPaths, in: directory)
        var filesExcluded: [URL] = []

        if let exclude = fileOptions?.exclude, !exclude.isEmpty {
            excluded = expandGlobs(exclude.joined(separator: ","), in: directory)
        } else {
            filesNotExcluded = allFiles
        }
        excluded.forEach { glob in
            filesExcluded = allFiles.filter { glob.matches($0.path) == true }
            let notExcluded = allFiles.filter { glob.matches($0.path) == false }
            filesNotExcluded.append(contentsOf: notExcluded)
        }

        if let include = fileOptions?.include, !include.isEmpty {
            included = expandGlobs(include.joined(separator: ","), in: directory)
            included.forEach { glob in
                files.append(contentsOf: filesNotExcluded.filter { glob.matches($0.path) == true })
            }
        } else {
            files = allFiles
        }

        files = files.filter { filesExcluded.contains($0) == false }

        return files
    }

    func getFiles(for paths: [String], in directory: String = FileManager.default.currentDirectoryPath) -> [URL] {
        var sanitizedPaths: [URL?] = []

        if paths.isEmpty {
            sanitizedPaths.append(URL(fileURLWithPath: directory))
        } else if paths.count == 1, paths[0] == "." {
            sanitizedPaths.append(URL(fileURLWithPath: directory))
        } else {
            sanitizedPaths.append(contentsOf: paths.map { (path) -> URL in
                if path.hasPrefix("/") { // absolute
                    return URL(fileURLWithPath: path)
                } else {
                    return URL(fileURLWithPath: directory).appendingPathComponent(path)
                }
            })
        }

        var files: [URL] = []
        for paths in sanitizedPaths.compactMap({ $0 }) {
            files.append(contentsOf: getFiles(for: paths))
        }

        return files
    }

    func getFiles(for url: URL) -> [URL] {
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
}
