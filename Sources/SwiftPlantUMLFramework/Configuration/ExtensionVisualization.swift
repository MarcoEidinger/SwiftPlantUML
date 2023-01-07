import Foundation

/// Options which and how extensions shall be considered for class diagram generation
public enum ExtensionVisualization: String, Codable {
    /// show all extensions
    case all
    /// merge extensions with their parent types
    case merged
    /// hide all extensions
    case none

    static func from(_ showExtensions: Bool) -> ExtensionVisualization {
        showExtensions ? .all : .none
    }

    /// default value if no configuration was found
    public static var `default`: ExtensionVisualization { .all }
}

extension Optional where Wrapped == ExtensionVisualization {
    var safelyUnwrap: ExtensionVisualization {
        self ?? ExtensionVisualization.default
    }
}
