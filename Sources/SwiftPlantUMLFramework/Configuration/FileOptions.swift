import Foundation
import Yams

/// Options which files shall be considered for class diagram generation
public struct FileOptions: Codable {
    /// memberwise initializer
    public init(include: [String]? = [], exclude: [String]? = []) {
        self.include = include
        self.exclude = exclude
    }

    /// paths to source files to be included
    public var include: [String]? = []
    /// paths to Swift source files to be excluded
    public var exclude: [String]? = []
}

extension FileOptions: CustomStringConvertible {
    public var description: String {
        let includeArray = include ?? []
        let excludeArray = exclude ?? []
        if includeArray.isEmpty && excludeArray.isEmpty {
            return "no values"
        } else {
            if includeArray.isEmpty {
                return "exclude: \(excludeArray.joined(separator: ", "))"
            } else if excludeArray.isEmpty {
                return "include: \(includeArray.joined(separator: ", "))"
            } else {
                return "include: \(includeArray.joined(separator: ", ")) && exclude: \(excludeArray.joined(separator: ", "))"
            }
        }

    }
}
