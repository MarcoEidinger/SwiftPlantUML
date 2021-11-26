import Foundation

/// Access Level for Swift variables and methods, see https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html
public enum AccessLevel: String, Codable {
    /// `open`
    case open
    /// `public`
    case `public`
    /// `internal`
    case `internal`
    /// `private`
    case `private`
}

// https://plantuml.com/class-diagram
/// Configuration options to influence the generation and visual representation of the class diagram
public struct Configuration: Codable {
    /// memberwise initializer
    public init(files: FileOptions = FileOptions(), elements: ElementOptions = ElementOptions(), hideShowCommands: [String]? = ["hide empty members"], skinparamCommands: [String]? = ["skinparam shadowing false"], includeRemoteURL: String? = nil, relationships: RelationshipOptions = RelationshipOptions(), stereotypes: Stereotypes = Stereotypes.default, relationshipExclude _: [String]? = nil) {
        self.files = files
        self.elements = elements
        self.hideShowCommands = hideShowCommands
        self.skinparamCommands = skinparamCommands
        self.includeRemoteURL = includeRemoteURL
        self.relationships = relationships
        self.stereotypes = stereotypes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let files = try container.decodeIfPresent(FileOptions.self, forKey: .files) {
            self.files = files
        }
        if let elements = try container.decodeIfPresent(ElementOptions.self, forKey: .elements) {
            self.elements = elements
        }
        if let hideShowCommands = try container.decodeIfPresent([String].self, forKey: .hideShowCommands) {
            self.hideShowCommands = hideShowCommands
        }
        if let skinparamCommands = try container.decodeIfPresent([String].self, forKey: .skinparamCommands) {
            self.skinparamCommands = skinparamCommands
        }
        if let includeRemoteURL = try container.decodeIfPresent(String.self, forKey: .includeRemoteURL) {
            self.includeRemoteURL = includeRemoteURL
        }
        if let relationships = try container.decodeIfPresent(RelationshipOptions.self, forKey: .relationships) {
            self.relationships = relationships
        }
        if let stereotypes = try container.decodeIfPresent(Stereotypes.self, forKey: .stereotypes) {
            self.stereotypes = stereotypes
        }
    }

    /// default configuration used if no configuration file was found
    public static let `default` = Configuration()

    /// options which files shall be considered for class diagram generation
    public var files = FileOptions()

    /// options which and how elements shall be considered for class diagram generation
    public var elements = ElementOptions()

    /// parameterize the display of entities using the hide/show command.https://plantuml.com/class-diagram#6a8ec84e53ede3ae
    public private(set) var hideShowCommands: [String]? = ["hide empty members"]
    /// add skinparam values to change colors and font of the drawing. See https://plantuml.com/skinparam for more details
    public private(set) var skinparamCommands: [String]? = ["skinparam shadowing false"]

    /// wil be added to PlantUMLScript as `!include` directive to include a file (from Internet/Intranet) in your diagram
    public private(set) var includeRemoteURL: String?

    /// options which relationships to show and how to style them
    public var relationships = RelationshipOptions()

    /// sterotypes (spotted character with background color and optional name) to be shown for an entity type
    public private(set) var stereotypes = Stereotypes(classStereotype: Stereotype.class, structStereotype: Stereotype.struct, extensionStereotype: Stereotype.extension, enumStereotype: Stereotype.enum, protocolStereotype: Stereotype.protocol)

    /// default initializer
    public init() {}
}
