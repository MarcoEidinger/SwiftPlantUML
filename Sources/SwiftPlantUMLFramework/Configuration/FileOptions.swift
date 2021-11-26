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
