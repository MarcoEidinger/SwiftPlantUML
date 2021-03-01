import Foundation

/// Theme
protocol Theme {
    /// wil be added to PlantUMLScript as `!include` directive to include a file (from Internet/Intranet) in your diagram
    var includeRemoteURL: String { get }
}

/// Open-source themes for PlantUML diagrams, see https://bschwarz.github.io/puml-themes/gallery.html
public enum PumlThemes: String, Theme {
    /// blackKnight (https://github.com/bschwarz/puml-themes/blob/master/themes/blackKnight/class-ex.svg)
    case blackKnight
    /// bluegray (https://github.com/bschwarz/puml-themes/blob/master/themes/bluegray/class-ex.svg)
    case bluegray
    /// cerulean-outline (https://github.com/bschwarz/puml-themes/blob/master/themes/cerulean-outline/class-ex.svg)
    case ceruleanOutline = "cerulean-outline"
    /// cerulean (https://github.com/bschwarz/puml-themes/blob/master/themes/cerulean/class-ex.svg)
    case cerulean
    /// cyborg-outline (https://github.com/bschwarz/puml-themes/blob/master/themes/cyborg-outline/class-ex.svg)
    case cyborgOutline = "cyborg-outline"
    /// cyborg (https://github.com/bschwarz/puml-themes/blob/master/themes/cyborg/class-ex.svg)
    case cyborg
    /// hacker (https://github.com/bschwarz/puml-themes/blob/master/themes/hacker/class-ex.svg)
    case hacker
    /// lightgray (https://github.com/bschwarz/puml-themes/blob/master/themes/lightgray/class-ex.svg)
    case lightgray
    /// materia-outline (https://github.com/bschwarz/puml-themes/blob/master/themes/materia-outline/class-ex.svg)
    case materiaOutline = "materia-outline"
    /// materia (https://github.com/bschwarz/puml-themes/blob/master/themes/materia/class-ex.svg)
    case materia
    /// metal (https://github.com/bschwarz/puml-themes/blob/master/themes/metal/class-ex.svg)
    case metal
    /// minty (https://github.com/bschwarz/puml-themes/blob/master/themes/minty/class-ex.svg)
    case minty
    /// resume-light (https://github.com/bschwarz/puml-themes/blob/master/themes/resume-light/class-ex.svg)
    case resumeLight = "resume-light"
    /// sandstone (https://github.com/bschwarz/puml-themes/blob/master/themes/sandstone/class-ex.svg)
    case sandstone
    /// silver (https://github.com/bschwarz/puml-themes/blob/master/themes/silver/class-ex.svg)
    case silver
    /// sketchy-outline (https://github.com/bschwarz/puml-themes/blob/master/themes/sketchy-outline/class-ex.svg)
    case sketchyOutline = "sketchy-outline"
    /// sketchy (https://github.com/bschwarz/puml-themes/blob/master/themes/sketchy/class-ex.svg)
    case sketchy
    /// solar (https://github.com/bschwarz/puml-themes/blob/master/themes/solar/class-ex.svg)
    case solar
    /// spacelab (https://github.com/bschwarz/puml-themes/blob/master/themes/spacelab/class-ex.svg)
    case spacelab
    /// superhero-outline (https://github.com/bschwarz/puml-themes/blob/master/themes/superhero-outline/class-ex.svg)
    case superheroOutline = "superhero-outline"
    /// superhero (https://github.com/bschwarz/puml-themes/blob/master/themes/superhero/class-ex.svg)
    case superhero
    /// united (https://github.com/bschwarz/puml-themes/blob/master/themes/united/class-ex.svg)
    case united

    var includeRemoteURL: String {
        "https://raw.githubusercontent.com/bschwarz/puml-themes/master/themes/\(rawValue)/puml-theme-\(rawValue).puml"
    }
}
