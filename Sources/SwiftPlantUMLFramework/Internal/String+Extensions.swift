import Foundation

internal extension String {
    mutating func appendAsNewLine(_ content: String) {
        append("\n\(content)")
    }
}

// https://useyourloaf.com/blog/how-to-percent-encode-a-url-string/
internal extension String {
    func stringByAddingPercentEncodingForFormData(plusForSpace: Bool = false) -> String? {
        let unreserved = "*-._"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)

        if plusForSpace {
            allowed.addCharacters(in: " ")
        }

        var encoded = addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
        if plusForSpace {
            encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        }
        return encoded
    }
}

internal extension String {
    func removeAngleBracketsWithContent() -> String {
        replacingOccurrences(of: "\\<[^\\]]+\\>", with: "", options: .regularExpression)
    }
}

internal extension String {
    func isMatching(searchPattern: String) -> Bool {
        let pattern = "^\(searchPattern)$"
            .replacingOccurrences(of: "[.+(){\\\\|]", with: "\\\\$0", options: .regularExpression)
            .replacingOccurrences(of: "?", with: "[^/]")
            .replacingOccurrences(of: "**/", with: "(.+/)?")
            .replacingOccurrences(of: "**", with: ".+")
            .replacingOccurrences(of: "*", with: "([^/]+)?")
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return true }
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: utf16.count)) != nil
    }
}

internal extension String {
    mutating func addOrSkipMemberAccessLevelAttribute(for element: SyntaxStructure, basedOn configuration: Configuration) {
        guard configuration.elements.showMemberAccessLevelAttribute == true else { return }

        switch element.accessibility {
        case .public, .open:
            self += "+"
        case .internal:
            self += "~"
        case .private:
            self += "-"
        default:
            ()
        }
    }
}
