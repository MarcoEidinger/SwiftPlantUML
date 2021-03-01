import Foundation

/// Defines how to output the generated diagram
public enum ClassDiagramOutput: String, CaseIterable, Codable {
    /// open class diagram in browser
    case browser
    /// open class diagram as image in browser
    case browserImageOnly
    /// print PlantUML script in console
    case consoleOnly
}
