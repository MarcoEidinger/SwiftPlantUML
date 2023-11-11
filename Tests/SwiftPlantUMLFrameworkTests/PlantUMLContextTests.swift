@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLContextTests: XCTestCase {
    func testUniqNameExtensionWithDefaultLabel() {
        let context = PlantUMLContext()
        context.uniqElementNames.append("aPublicStruct")

        let struct1 = SyntaxStructure(kind: .struct, name: "aPublicStruct")
        context.uniqueNameForElement[struct1] = "aPublicStruct"

        _ = context.uniqName(item: SyntaxStructure(kind: .extension, name: "aPublicStruct"), relationship: "ext")
        XCTAssertEqual(context.extnConnections.first, "aPublicStruct <.. aPublicStruct0 : ext")
    }

    func testUniqNameExtensionWithCustomLabel() {
        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(dependency: Relationship(label: "extends"))))

        context.uniqElementNames.append("aPublicStruct")

        let struct1 = SyntaxStructure(kind: .struct, name: "aPublicStruct")
        context.uniqueNameForElement[struct1] = "aPublicStruct"

        _ = context.uniqName(item: SyntaxStructure(kind: .extension, name: "aPublicStruct"), relationship: "ext")
        XCTAssertEqual(context.extnConnections.first, "aPublicStruct <.. aPublicStruct0 : extends")
    }

    func testAddLinkingInheritanceDefault() {
        let superclass = SyntaxStructure(kind: .extension, name: "aPublicStruct")
        let subclass = SyntaxStructure(kind: .struct, name: "SubOfaPublicStruct")

        let context = PlantUMLContext()

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.first, "aPublicStruct <|-- SubOfaPublicStruct : inherits")
    }

    func testAddLinkingInheritanceWithCustomLabel() {
        let superclass = SyntaxStructure(kind: .extension, name: "aPublicStruct")
        let subclass = SyntaxStructure(kind: .struct, name: "SubOfaPublicStruct")
        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(inheritance: Relationship(label: "inherits from"))))

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.first, "aPublicStruct <|-- SubOfaPublicStruct : inherits from")
    }

    func testAddLinkingInheritanceSkip() {
        let superclass = SyntaxStructure(kind: .extension, name: "Codable")
        let subclass = SyntaxStructure(kind: .struct, name: "SubOfCodable")

        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(inheritance: Relationship(exclude: ["Codable"]))))

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.count, 0)
    }
    
    func testAddLinkingEscapeName() {
        let superclass = SyntaxStructure(kind: .class, name: "@unchecked Sendable")
        let subclass = SyntaxStructure(kind: .class, name: "Yoo")
        let context = PlantUMLContext()

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.first!, #""@unchecked Sendable" <|-- Yoo : inherits"#)
    }
}
