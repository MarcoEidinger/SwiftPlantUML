import Foundation

extension Array where Element == SyntaxStructure {
    /// order: protocols first, then non-extensions (i.e protocols, structs, classes, enums). Extensions last/
    /// This ensures that linking is correct
    /// see https://github.com/MarcoEidinger/SwiftPlantUML/issues/47
    /// as well as relationship label
    /// see https://github.com/MarcoEidinger/SwiftPlantUML/issues/49
    func orderedByProtocolsFirstExtensionsLast() -> [SyntaxStructure] {
        return sorted(by: { $0.kind ?? .struct < $1.kind ?? .struct })
    }
}

extension ElementKind: Comparable {
    private var sortOrder: Int {
        switch self {
        case .protocol:
            return 0
        case .extension:
            return 2
        default:
            return 1
        }
    }

    static func < (lhs: ElementKind, rhs: ElementKind) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

