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
    }

    func encodedText(completionHandler: @escaping (Result<String, NetworkError>) -> Void) {
        let escapedScript = text.stringByAddingPercentEncodingForFormData(plusForSpace: true) ?? ""
        let parameters = "type=png&plantuml=\(escapedScript)"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://www.planttext.com/api/scripting")!, timeoutInterval: Double.infinity)
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("no-cache", forHTTPHeaderField: "Pragma")
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.96 Safari/537.36", forHTTPHeaderField: "User-Agent")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("https://www.planttext.com", forHTTPHeaderField: "Origin")
        request.addValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.addValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
        request.addValue("empty", forHTTPHeaderField: "Sec-Fetch-Dest")
        request.addValue("https://www.planttext.com/", forHTTPHeaderField: "Referer")
        request.addValue("en-US,en;q=0.9,de;q=0.8", forHTTPHeaderField: "Accept-Language")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completionHandler(.failure(.badURL))
                return
            }
            let encodedText = String(data: data, encoding: .utf8)!
            completionHandler(.success(encodedText))
        }
        task.resume()
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
