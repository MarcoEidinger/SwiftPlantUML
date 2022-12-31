import Foundation

/**
 Built-in themes for PlantUML diagrams, see https://plantuml.com/theme

 View class diagram examples on https://the-lum.github.io/puml-themes-gallery by appending `/gallery/img/Class-<themeName>.svg`, e.g. https://the-lum.github.io/puml-themes-gallery/gallery/img/Class-crt-amber.svg
 */
public enum Theme: Codable {
    /// amiga
    case amiga
    /// awsOrange
    case awsOrange
    /// blackKnight
    case blackKnight
    /// bluegray
    case bluegray
    /// blueprint
    case blueprint
    /// carbon-gray
    case carbonGray
    /// cerulean-outline
    case ceruleanOutline
    /// cerulean
    case cerulean
    /// cloudscape-design
    case cloudscapeDesign
    /// crt-amber
    case crtAmber
    /// crt-green
    case crtGreen
    /// cyborg-outline
    case cyborgOutline
    /// cyborg
    case cyborg
    /// hacker
    case hacker
    /// lightgray
    case lightgray
    /// mars
    case mars
    /// materia-outline
    case materiaOutline
    /// materia
    case materia
    /// metal
    case metal
    /// mimeograph
    case mimeograph
    /// minty
    case minty
    /// plain
    case plain
    /// reddress-darkblue
    case reddressDarkblue
    /// reddress-darkgreen
    case reddressDarkgreen
    /// reddress-darkorange
    case reddressDarkorange
    /// reddress-darkred
    case reddressDarkred
    /// reddress-lightblue
    case reddressLightblue
    /// reddress-lighgreen
    case reddressLightgreen
    /// reddress-lightorange
    case reddressLightorange
    /// reddress-lightred
    case reddressLightred
    /// sandstone
    case sandstone
    /// silver
    case silver
    /// sketchy-outline
    case sketchyOutline
    /// sketchy
    case sketchy
    /// spacelab
    case spacelab
    /// spacelab-white
    case spacelabWhite
    /// superhero-outline
    case superheroOutline
    /// superhero
    case superhero
    /// toy
    case toy
    /// united
    case united
    /// vibrant
    case vibrant

    /// to load themes from local or from external files
    /// local example: `foo from /path/to/themes/folder`
    /// remote example: `amiga from https://raw.githubusercontent.com/plantuml/plantuml/master/themes`
    case __directive__(String) // swiftlint:disable:this identifier_name

    var rawValue: String {
        switch self {
        case let .__directive__(name):
            return "\(name)"
        default:
            return String(describing: self).camelCaseToKebapCase()
        }
    }
}

private extension String {
    func camelCaseToKebapCase() -> String {
        let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
        let normalPattern = "([a-z0-9])([A-Z])"
        return processKebapCaseRegex(pattern: acronymPattern)?
            .processKebapCaseRegex(pattern: normalPattern)?.lowercased() ?? lowercased()
    }

    func processKebapCaseRegex(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1-$2")
    }
}
