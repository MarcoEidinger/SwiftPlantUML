import Foundation

public enum ExtensionVisualization: String, Codable {
    case all
    case merged
    case none

    static func from(_ showExtensions: Bool) -> ExtensionVisualization {
        showExtensions ? .all : .none
    }

    public static var `default`: ExtensionVisualization { .all }
}

extension Optional where Wrapped == ExtensionVisualization {
    var safelyUnwrap: ExtensionVisualization {
        return self ?? ExtensionVisualization.default
    }
}

///// Options which and how extensions shall be considered for class diagram generation
//public struct ExtensionOptions: Codable {
//    /// TOOD
//    public var visualization: ExtensionVisualization? = ExtensionVisualization.default
//
//    /// show Swift extensions  (default: true)
//    // public var showExtensions: Bool?
//
//    /// merge extensions so that extension members will be displayed as part of the main type and not as a separate element in the diagram
//    // public var mergeExtensions: Bool?
//
//    /// A suffix added to an extension member which will be displayed as part of the main type . You can use [Emoji](https://plantuml.com/creole#68305e25f5788db0), [OpenIconic](https://plantuml.com/creole#041a1eb0031c373d), or any string
//    public private(set) var mergedExtensionMemberIndicator: String? = "<&bolt>"
//
//    /// decoding initializer
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if let visualization = try container.decodeIfPresent(String.self, forKey: .visualization) {
//            self.visualization = ExtensionVisualization(rawValue: visualization)
//        }
////        if let showExtensions = try container.decodeIfPresent(Bool.self, forKey: .showExtensions) {
////            self.showExtensions = showExtensions
////        }
////        if let mergeExtensions = try container.decodeIfPresent(Bool.self, forKey: .mergeExtensions) {
////            self.mergeExtensions = mergeExtensions
////        }
//        if let mergedExtensionMemberIndicator = try container.decodeIfPresent(String.self, forKey: .mergedExtensionMemberIndicator) {
//            self.mergedExtensionMemberIndicator = mergedExtensionMemberIndicator
//        }
//        // self.visualization = .strip
//    }
//
//    /// memberwise initializer
//    public init(visualization: ExtensionVisualization? = ExtensionVisualization.default, showExtensions _: Bool? = nil, mergeExtensions _: Bool? = nil, mergedExtensionMemberIndicator: String? = "<&bolt>") {
//        self.visualization = visualization
//        // self.showExtensions = showExtensions
//        // self.mergeExtensions = mergeExtensions
//        self.mergedExtensionMemberIndicator = mergedExtensionMemberIndicator
//    }
//}
