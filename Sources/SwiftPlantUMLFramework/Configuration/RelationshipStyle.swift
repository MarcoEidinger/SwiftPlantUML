import Foundation

/// Inline style for relation (linking or arrow)
public enum RelationshipInlineStyle: String, Codable {
    /// bold
    case bold
    /// dashed (-----)
    case dashed
    /// dotted (.....)
    case dotted
    /// hidden / invisible
    case hidden
    /// regular
    case plain
}

/// Style information for or relation (linking or arrow) and its label
public struct RelationshipStyle: Codable {
    /// line style
    public private(set) var lineStyle: RelationshipInlineStyle = .plain
    /// line color
    public private(set) var lineColor: Color = .Black
    /// text color for label
    public private(set) var textColor: Color = .Black

    var plantuml: String {
        "#line:\(lineColor);line.\(lineStyle);text:\(textColor)"
    }
}
