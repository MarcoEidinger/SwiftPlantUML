import Foundation
import SourceKittenFramework

internal extension SyntaxStructure {
    private static func create(from file: File, sdkPath: String? = nil) -> SyntaxStructure? {
        guard let sdkPath = sdkPath else { return createStructure(from: file) }
        guard let docs = SwiftDocs(file: file, arguments: ["-j4", "-sdk", sdkPath, file.path ?? ""]) else {
            Logger.shared.warning("cannot parse source code with type inference! Is Applications/Xcode.app available?")
            return createStructure(from: file)
        }
        let structure = Structure(sourceKitResponse: docs.docsDictionary)
        let jsonData = structure.description.data(using: .utf8)!
        return try! JSONDecoder().decode(SyntaxStructure.self, from: jsonData) // swiftlint:disable:this force_try
    }

    private static func createStructure(from file: File) -> SyntaxStructure? {
        let structure = try! Structure(file: file) // swiftlint:disable:this force_try
        let jsonData = structure.description.data(using: .utf8)!
        return try! JSONDecoder().decode(SyntaxStructure.self, from: jsonData) // swiftlint:disable:this force_try
    }

    static func create(from fileOnDisk: URL, sdkPath: String? = nil) -> SyntaxStructure? {
        let methodStart = Date()
        guard let file = File(path: fileOnDisk.path) else {
            Logger.shared.error("not able to read contents of file \(fileOnDisk)")
            return nil
        }
        let structure = create(from: file, sdkPath: sdkPath)
        let methodFinish = Date()
        let executionTime = methodFinish.timeIntervalSince(methodStart)
        Logger.shared.debug("read \(fileOnDisk) \((sdkPath != nil && !sdkPath!.isEmpty) ? "parsing with SDK" : "") in \(executionTime)")
        return structure
    }

    static func create(from contents: String) -> SyntaxStructure? {
        let file = File(contents: contents)
        return create(from: file)
    }
}
