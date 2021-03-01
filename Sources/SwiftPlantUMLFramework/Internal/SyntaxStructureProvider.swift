import Foundation
import SourceKittenFramework

internal extension SyntaxStructure {
    private static func create(from file: File) -> SyntaxStructure? {
        let structure = try! Structure(file: file) // swiftlint:disable:this force_try
        let jsonData = structure.description.data(using: .utf8)!
        return try! JSONDecoder().decode(SyntaxStructure.self, from: jsonData) // swiftlint:disable:this force_try
    }

    static func create(from fileOnDisk: URL) -> SyntaxStructure? {
        guard let file = File(path: fileOnDisk.path) else {
            Logger.shared.error("not able to read contents of file \(fileOnDisk)")
            return nil
        }
        return create(from: file)
    }

    static func create(from contents: String) -> SyntaxStructure? {
        let file = File(contents: contents)
        return create(from: file)
    }
}
