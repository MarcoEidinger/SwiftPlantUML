import Foundation
import SourceKittenFramework

internal extension SyntaxStructure {
    private static func create(from file: File) -> SyntaxStructure? {
        let structure = try! Structure(file: file)
        let jsonData = structure.description.data(using: .utf8)!
        return try! JSONDecoder().decode(SyntaxStructure.self, from: jsonData)
    }

    static func create(from file: URL) -> SyntaxStructure? {
        guard let file = File(path: file.path) else { return nil }
        return create(from: file)
    }

    static func create(from contents: String) -> SyntaxStructure? {
        let file = File(contents: contents)
        return create(from: file)
    }
}
