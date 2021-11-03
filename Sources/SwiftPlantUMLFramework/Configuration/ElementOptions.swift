import Foundation

/// Options which and how elements shall be considered for class diagram generation
public struct ElementOptions: Codable {
    /// only elements (classes, structs, ...) with the specified access level will be processed and rendered in the class diagram
    public private(set) var havingAccessLevel: [AccessLevel] = [.open, .public, .internal, .private]
    /// only members (properties and functions) with the specified access level will be processed and renderd in the class diagram
    public private(set) var showMembersWithAccessLevel: [AccessLevel] = [.open, .public, .internal, .private]

    /// show generic type and type constraint information for a struct/class (default: true)
    public private(set) var showGenerics: Bool = true

    /// show Swift extensions  (default: true)
    public private(set) var showExtensions: Bool = true

    /// show [access level](https://plantuml.com/class-diagram#3644720244dd6c6a) for members
    public private(set) var showMemberAccessLevelAttribute: Bool = true

    /// exclude elements for given names (wildcard support with `*`), e.g. use `*Test*`to hide classes/structs/... who contain `Test` in their name
    public private(set) var exclude: [String]?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let havingAccessLevel = try container.decodeIfPresent([AccessLevel].self, forKey: .havingAccessLevel) {
            self.havingAccessLevel = havingAccessLevel
        }
        if let showMembersWithAccessLevel = try container.decodeIfPresent([AccessLevel].self, forKey: .showMembersWithAccessLevel) {
            self.showMembersWithAccessLevel = showMembersWithAccessLevel
        }
        if let showGenerics = try container.decodeIfPresent(Bool.self, forKey: .showGenerics) {
            self.showGenerics = showGenerics
        }
        if let showExtensions = try container.decodeIfPresent(Bool.self, forKey: .showExtensions) {
            self.showExtensions = showExtensions
        }
        if let showMemberAccessLevelAttribute = try container.decodeIfPresent(Bool.self, forKey: .showMemberAccessLevelAttribute) {
            self.showMemberAccessLevelAttribute = showMemberAccessLevelAttribute
        }
        if let exclude = try container.decodeIfPresent([String].self, forKey: .exclude) {
            self.exclude = exclude
        }
    }

    internal init(havingAccessLevel: [AccessLevel] = [.open, .public, .internal, .private], showMembersWithAccessLevel: [AccessLevel] = [.open, .public, .internal, .private], showGenerics: Bool = true, showExtensions: Bool = true, showMemberAccessLevelAttribute: Bool = true, exclude: [String]? = nil) {
        self.havingAccessLevel = havingAccessLevel
        self.showMembersWithAccessLevel = showMembersWithAccessLevel
        self.showGenerics = showGenerics
        self.showExtensions = showExtensions
        self.showMemberAccessLevelAttribute = showMemberAccessLevelAttribute
        self.exclude = exclude
    }
}
