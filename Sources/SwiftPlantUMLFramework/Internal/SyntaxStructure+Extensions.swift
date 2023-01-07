import Foundation

extension Array where Element == SyntaxStructure {
    /// order: protocols first, then non-extensions (i.e protocols, structs, classes, enums). Extensions last/
    /// This ensures that linking is correct
    /// see https://github.com/MarcoEidinger/SwiftPlantUML/issues/47
    /// as well as relationship label
    /// see https://github.com/MarcoEidinger/SwiftPlantUML/issues/49
    func orderedByProtocolsFirstExtensionsLast() -> [SyntaxStructure] {
        sorted(by: { $0.kind ?? .struct < $1.kind ?? .struct })
    }

    /// merges extensions in two ways:
    /// 1) adds members to the main declaration if it exists OR
    /// 2) adds members to the first extension if no main declaration can be found. This can occour if the main declaration is in another module that was not scanned. For example: extensions on `String` will be merged into the first extension of `String` as no main declaration of `String` can be found as it a type in Swift Standard Library
    /// - Parameter mergedMemberIndicator: string that gets appened as suffix to a member that originates from an extension
    /// - Returns: new array of `SyntaxStructure` that contains no more than 1 extension per type
    func mergeExtensions(mergedMemberIndicator: String? = "<&bolt>") -> [SyntaxStructure] {
        var processedItems = self

        for structure in self where structure.kind == .extension {
            guard let parentIndex = processedItems.firstIndex(where: { $0.name == structure.name }) else {
                continue
            }
            var parent = processedItems[parentIndex]
            // in case main declaration cannot be found for an extension then extension might find itself. Do not merge with itself :)
            guard structure != parent else { continue }
            processedItems.removeAll(where: { $0 == structure })
            // merge members of extension with main declaration (or: the first extension if no main declaration was found)
            guard var members = structure.substructure else { continue }
            if let memberSuffix = mergedMemberIndicator, parent.kind != .extension {
                for index in members.indices {
                    guard members[index].name != nil else { continue }
                    members[index].memberSuffix = memberSuffix
                }
            }
            parent.substructure?.append(contentsOf: members)
            processedItems[parentIndex] = parent
        }
        // }
        return processedItems
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
