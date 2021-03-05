@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLContextTests: XCTestCase {
    func testUniqNameExtensionWithDefaultLabel() {
        let context = PlantUMLContext()
        context.uniqElementNames.append("aPublicStruct")
        _ = context.uniqName(item: SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .extension, name: "aPublicStruct", runtimename: nil, substructure: nil, typename: nil), relationship: "ext")
        XCTAssertEqual(context.extnConnections.first, "aPublicStruct <.. aPublicStruct0 : ext")
    }

    func testUniqNameExtensionWithCustomLabel() {
        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(dependency: Relationship(label: "extends"))))
        context.uniqElementNames.append("aPublicStruct")
        _ = context.uniqName(item: SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .extension, name: "aPublicStruct", runtimename: nil, substructure: nil, typename: nil), relationship: "ext")
        XCTAssertEqual(context.extnConnections.first, "aPublicStruct <.. aPublicStruct0 : extends")
    }

    func testAddLinkingInheritanceDefault() {
        let superclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .extension, name: "aPublicStruct", runtimename: nil, substructure: nil, typename: nil)
        let subclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .struct, name: "SubOfaPublicStruct", runtimename: nil, substructure: nil, typename: nil)

        let context = PlantUMLContext()

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.first, "aPublicStruct <|-- SubOfaPublicStruct : inherits")
    }

    func testAddLinkingInheritanceWithCustomLabel() {
        let superclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .extension, name: "aPublicStruct", runtimename: nil, substructure: nil, typename: nil)
        let subclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .struct, name: "SubOfaPublicStruct", runtimename: nil, substructure: nil, typename: nil)
        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(inheritance: Relationship(label: "inherits from"))))

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.first, "aPublicStruct <|-- SubOfaPublicStruct : inherits from")
    }

    func testAddLinkingInheritanceSkip() {
        let superclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .extension, name: "Codable", runtimename: nil, substructure: nil, typename: nil)
        let subclass = SyntaxStructure(accessibility: nil, attribute: nil, attributes: nil, elements: nil, inheritedTypes: nil, kind: .struct, name: "SubOfCodable", runtimename: nil, substructure: nil, typename: nil)

        let context = PlantUMLContext(configuration: Configuration(relationships: RelationshipOptions(inheritance: Relationship(exclude: ["Codable"]))))

        _ = context.uniqName(item: subclass, relationship: "inherits")
        context.addLinking(item: subclass, parent: superclass)

        XCTAssertEqual(context.connections.count, 0)
    }
}
