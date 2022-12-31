import Foundation
import SwiftUI

internal enum NetworkError: Error {
    case badURL
}

/// Swift type representing a PlantUML script (@startuml ... @enduml)
public struct PlantUMLScript {
    /// textual representation of the script (@startuml ... @enduml)
    public private(set) var text: String = ""

    /// public private(set) var configuration: PlantUMLConfiguration = .default
    private var context: PlantUMLContext

    /// default initializer
    internal init(items: [SyntaxStructure], configuration: Configuration = .default) {
        context = PlantUMLContext(configuration: configuration)

        let methodStart = Date()

        let STR2REPLACE = "STR2REPLACE"

//        let plantumlTemplate = """
//        @startuml
//        ' STYLE START
//        hide empty members
//        skinparam shadowing false
//        ' STYLE END
//
//        STR2REPLACE
//        @enduml
//        """

        var plantumlTemplate = "@startuml"
        if let theme = configuration.theme {
            plantumlTemplate.appendAsNewLine("!theme \(theme.rawValue)")
        }
        if let includeRemoteURL = configuration.includeRemoteURL {
            plantumlTemplate.appendAsNewLine("!include \(includeRemoteURL)")
        }
        plantumlTemplate.appendAsNewLine(defaultStyling)
        plantumlTemplate.appendAsNewLine("STR2REPLACE")
        plantumlTemplate.appendAsNewLine("@enduml")

        var replacingText = "\n"

        for (index, element) in items.enumerated() {
            if let text = processStructureItem(item: element, index: index) {
                replacingText.appendAsNewLine(text)
            }
        }

        let neep = replacingText + "\n" + context.connections.joined(separator: "\n") + "\n" + context.extnConnections.joined(separator: "\n")

        text = plantumlTemplate.replacingOccurrences(of: STR2REPLACE, with: neep)

        Logger.shared.debug("PlantUML script created in \(Date().timeIntervalSince(methodStart)) seconds")
    }

    /**
      encodes diagram text description according to PlantUML.  See https://plantuml.com/en/text-encoding for more information.

       1. Encoded in UTF-8
       2. Compressed using Deflate algorithm
       3. Reencoded in ASCII using a transformation *close* to base64

     - Returns: encoded diagram text description
     */
    public func encodeText() -> String {
        PlantUMLText(rawValue: text).encodedValue
    }

    /// default styling block to hide empty members and disable shadowing
    internal var defaultStyling: String {
        let hideShowCommands: [String] = context.configuration.hideShowCommands ?? ["hide empty members"]
        let skinparamCommands: [String] = context.configuration.skinparamCommands ?? ["skinparam shadowing false"]

        if hideShowCommands.isEmpty, skinparamCommands.isEmpty {
            return ""
        } else {
            return """
            ' STYLE START
            \(hideShowCommands.joined(separator: "\n"))
            \(skinparamCommands.joined(separator: "\n"))
            ' STYLE END
            """
        }
    }

    mutating func processStructureItem(item: SyntaxStructure, index _: Int) -> String? {
        let processableKinds: [ElementKind] = [.class, .struct, .extension, .enum, .protocol]
        guard let elementKind = item.kind else { return nil }
        guard processableKinds.contains(elementKind) else { return nil }
        return item.plantuml(context: context) ?? nil
    }
}
