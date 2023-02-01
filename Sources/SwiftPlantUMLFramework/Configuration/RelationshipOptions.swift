import Foundation

/// Options which relationships to show and how to style them in a class diagram
public struct RelationshipOptions: Codable {
    /// memberwise initializer
    public init(inheritance: Relationship? = Relationship(label: "inherits"), realize: Relationship? = Relationship(label: "conforms to"), dependency: Relationship? = Relationship(label: "ext")) {
        self.inheritance = inheritance
        self.realize = realize
        self.dependency = dependency
    }

    /// struct/class inherits from another struct/class
    public var inheritance: Relationship? = Relationship(label: "inherits")
    /// struct/class realizes protocol
    public var realize: Relationship? = Relationship(label: "conforms to")
    /// struct/class has exension
    public var dependency: Relationship? = Relationship(label: "ext") // , style: RelationshipStyle(lineStyle: .bold, lineColor: .BlueViolet, textColor: .BlueViolet))
}

/// Relationship metadata on if/how ot visualzie them in a class diagram
public struct Relationship: Codable {
    /// memberwise initializer
    public init(label: String? = nil, style: RelationshipStyle? = nil, exclude: [String]? = nil) {
        self.label = label
        self.style = style
        self.exclude = exclude
    }

    /// Label shown next to relationship arrow
    public var label: String?
    /// style information for relation (linking or arrow) and its label
    public var style: RelationshipStyle?

    /**
     exclude relationships (of this kind) for given names (wildcard support with `*`)

     Example to exclude relationships in which entities inherit from `Codable`

     ```
     let relationshipOptions = RelationshipOptions(inheritance: Relationship(exclude: ["Codable"]))
     ```
     */
    public var exclude: [String]?
}
