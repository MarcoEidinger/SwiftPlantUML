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
