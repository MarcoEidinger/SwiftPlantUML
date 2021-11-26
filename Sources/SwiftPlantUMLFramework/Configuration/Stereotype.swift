import Foundation

/// Stereotypes for entity types
public struct Stereotypes: Codable {
    /// create a new `Stereotypes` struct with default values
    public static var `default`: Stereotypes {
        return Stereotypes(classStereotype: Stereotype.class, structStereotype: Stereotype.struct, extensionStereotype: Stereotype.extension, enumStereotype: Stereotype.enum, protocolStereotype: Stereotype.protocol)
    }

    /// memberwise initializer
    public init(classStereotype: Stereotype? = nil, structStereotype: Stereotype? = nil, extensionStereotype: Stereotype? = nil, enumStereotype: Stereotype? = nil, protocolStereotype: Stereotype? = nil) {
        self.class = classStereotype
        self.struct = structStereotype
        self.extension = extensionStereotype
        self.enum = enumStereotype
        self.protocol = protocolStereotype
    }

    /// stereotype to be applied for all classes
    public var `class`: Stereotype?
    /// stereotype to be applied for all structs
    public var `struct`: Stereotype?
    /// stereotype to be applied for all extensions
    public var `extension`: Stereotype?
    /// stereotype to be applied for all enums
    public var `enum`: Stereotype?
    /// stereotype to be applied for all protocols
    public var `protocol`: Stereotype?
}

/// you can define your own spot for a entity when you define the stereotype, adding a single character and a color. For further info see https://plantuml.com/class-diagram#4b62dd14f1d33739
public struct Stereotype: Codable {
    /// displayed as << name >> in diagram
    public var name: String?
    /// spotted character with background color
    public var spot: Spot

    var plantuml: String {
        guard let name = name else {
            return "<< (\(spot.character), \(spot.color.rawValue)) >>"
        }
        return "<< (\(spot.character), \(spot.color.rawValue)) \(name) >>"
    }

    /// default spot for classes
    public private(set) static var `class` = Stereotype(spot: Spot(character: "C", color: .DarkSeaGreen))
    /// default spot for structs
    public private(set) static var `struct` = Stereotype(name: "struct", spot: Spot(character: "S", color: .SkyBlue))
    /// default spot for extensions
    public private(set) static var `extension` = Stereotype(name: "extension", spot: Spot(character: "X", color: .Orchid))
    /// default spot for enums
    public private(set) static var `enum` = Stereotype(name: "enum", spot: Spot(character: "E", color: .LightSteelBlue))
    /// default spot for protocols
    public private(set) static var `protocol` = Stereotype(name: "protocol", spot: Spot(character: "P", color: .GoldenRod))
}

/// Usually, a spotted character (C, S, E, X or P) is used for classes, struct, enum, extension and protocols. But you can define your own spot for a entity when you define the stereotype, adding a single character and a color. For further info see https://plantuml.com/class-diagram#4b62dd14f1d33739
public struct Spot: Codable {
    /// spotted character
    public var character: Character
    /// background color of spot
    public var color: Color
}

/// :nodoc:
extension Character: Codable {
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        guard !string.isEmpty else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Decoder expected a Character but found an empty string.")
        }
        guard string.count == 1 else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Decoder expected a Character but found a string: \(string)")
        }
        self = string[string.startIndex]
    }

    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(self))
    }
}
