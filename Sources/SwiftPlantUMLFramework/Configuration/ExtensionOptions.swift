import Foundation

/// Options which and how extensions shall be considered for class diagram generation
public struct ExtensionOptions: Codable {
    /// show Swift extensions  (default: true)
    public var showExtensions: Bool = true

    /// merge extensions so that extension members will be displayed as part of the main type and not as a separate element in the diagram
    public var mergeExtensions: Bool = false

    /// A suffix added to an extension member which will be displayed as part of the main type . You can use [Emoji](https://plantuml.com/creole#68305e25f5788db0), [OpenIconic](https://plantuml.com/creole#041a1eb0031c373d), or any string
    public private(set) var mergeExtensionMemberSuffixIndicator: String? = "<&bolt>"

    /// decoding initializer
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let showExtensions = try container.decodeIfPresent(Bool.self, forKey: .showExtensions) {
            self.showExtensions = showExtensions
        }
        if let mergeExtensions = try container.decodeIfPresent(Bool.self, forKey: .mergeExtensions) {
            self.mergeExtensions = mergeExtensions
        }
        if let mergeExtensionMemberSuffixIndicator = try container.decodeIfPresent(String.self, forKey: .mergeExtensionMemberSuffixIndicator) {
            self.mergeExtensionMemberSuffixIndicator = mergeExtensionMemberSuffixIndicator
        }
    }

    /// memberwise initializer
    public init(showExtensions: Bool = true, mergeExtensions: Bool = false, mergeExtensionMemberSuffixIndicator: String? = "<&bolt>") {
        self.showExtensions = showExtensions
        self.mergeExtensions = mergeExtensions
        self.mergeExtensionMemberSuffixIndicator = mergeExtensionMemberSuffixIndicator
    }
}
