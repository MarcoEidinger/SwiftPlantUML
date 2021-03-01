// import Foundation
// import Yams
//
// struct ConfigFileWriter {
//    static func saveConfigAsYaml() throws {
//        let config = Configuration(output: .browser, files: FileOptions(include: ["Main.swift"], exclude: ["test.swift"]), elements: ElementOptions(havingAccessLevel: [.public], showMembersWithAccessLevel: [.public], showGenerics: true, showExtensions: true, showMemberAccessLevelAttribute: true, exclude: ["Test*"]), hideShowCommands: ["show"], skinparamCommands: ["skin"], includeRemoteURL: "meep", relationships: RelationshipStyles(class: RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .AliceBlue), struct: RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .AliceBlue), extension: RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .AliceBlue), enum: RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .AliceBlue), protocol: RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .AliceBlue)), relationshipLabels: RelationshipLabels(generic: "generic", inheritance: "inheritance", realize: "realize", dependency: "dependency"), stereotypes: Stereotypes(class: Stereotype(name: "class", spot: Spot(character: "C", color: .AliceBlue)), struct: Stereotype(spot: Spot(character: "S", color: .AntiqueWhite)), extension: Stereotype(spot: Spot(character: "S", color: .AntiqueWhite)), enum: Stereotype(spot: Spot(character: "S", color: .AntiqueWhite)), protocol: Stereotype(spot: Spot(character: "S", color: .AntiqueWhite))))
//        let encoder = YAMLEncoder()
//        let encodedYAML = try encoder.encode(config)
//        print(encodedYAML)
//        let filename = getDocumentsDirectory().appendingPathComponent("swiftplanuml.yml")
//
//        try! encodedYAML.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//    }
//
//    static func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
// }
