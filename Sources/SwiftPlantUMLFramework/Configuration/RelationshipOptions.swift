import Foundation

/// Options which relationships to show and how to style them in a class diagram
public struct RelationshipOptions: Codable {
    /// struct/class inherits from another struct/class
    public var inheritance: Relationship? = Relationship(label: "inherits")
    /// struct/class realizes protocol
    public var realize: Relationship? = Relationship(label: "confirms to")
    /// struct/class has exension
    public var dependency: Relationship? = Relationship(label: "ext") // , style: RelationshipStyle(lineStyle: .bold, lineColor: .BlueViolet, textColor: .BlueViolet))
}

/// Relationship metadata on if/how ot visualzie them in a class diagram
public struct Relationship: Codable {
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
