import SourceKittenFramework
@testable import SwiftPlantUMLFramework
import XCTest

final class SyntaxStructureTests: XCTestCase {
    func testStructureCreate() {
        let cut = try! SyntaxStructure.create(from: getTestFile())
        XCTAssertNotNil(cut)
    }

    func testStructureElementFind() {
        let cut = try! SyntaxStructure.create(from: getTestFile())
        let found = cut?.find(.class, named: "Vehicle")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureClass() {
        let cut = try! SyntaxStructure.create(from: getTestFile())
        let found = cut?.find(.class, named: "Vehicle")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureStruct() {
        let cut = try! SyntaxStructure.create(from: getTestFile())
        let found = cut?.find(.struct, named: "Rect")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureProtocol() {
        let cut = try! SyntaxStructure.create(from: getTestFile())
        let found = cut?.find(.protocol, named: "FullyNamed")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureExtension() {
        let cut = SyntaxStructure.create(from: "public extension aExtension {}")
        let found = cut?.find(.extension, named: "aExtension")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureElementsExcluded() {
        let cut = SyntaxStructure.create(from: "public extension aExtension {}")
        let found = cut?.find(.extension, named: "aExtension")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(exclude: ["*Ext*"]))))
        XCTAssertNil(plantUMLElement)
    }

    func testStructureExtensionExcluded() {
        let cut = SyntaxStructure.create(from: "public extension aExtension {}")
        let found = cut?.find(.extension, named: "aExtension")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showExtensions: false))))
        XCTAssertNil(plantUMLElement)
    }

    func testStructurePublicExcluded() {
        let cut = SyntaxStructure.create(from: "struct aStruct {}")
        let found = cut?.find(.struct, named: "aStruct")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(havingAccessLevel: [.public]))))
        XCTAssertNil(plantUMLElement)
    }

    func testStructureOpenElementIncludedAutomatically() {
        let cut = SyntaxStructure.create(from: "open class anOpenClass {}")
        let found = cut?.find(.class, named: "anOpenClass")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext())
        XCTAssertNotNil(plantUMLElement)
    }

    func testStructureOpenElementExcludedByNotSpecifyingAccessLevelInConfig() {
        let cut = SyntaxStructure.create(from: "open class anOpenClass {}")
        let found = cut?.find(.class, named: "anOpenClass")
        XCTAssertNotNil(found)
        let plantUMLElement = found?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(havingAccessLevel: [.public]))))
        XCTAssertNil(plantUMLElement)
    }

    func testStructureShowAccessLevelAttribute() {
        let cut = SyntaxStructure.create(from: "struct aStruct { public var computedVariable: String { return \"Hello World\" }}")
        let plantUMLElement = cut?.find(.struct, named: "aStruct")?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showMemberAccessLevelAttribute: true))))
        XCTAssertEqual(plantUMLElement, "class \"aStruct\" as aStruct << (S, SkyBlue) struct >> { \n  +computedVariable : String \n}")
    }

    func testStructureHideAccessLevelAttribute() {
        let cut = SyntaxStructure.create(from: "struct aStruct { public var computedVariable: String { return \"Hello World\" }}")
        let plantUMLElement = cut?.find(.struct, named: "aStruct")?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showMemberAccessLevelAttribute: false))))
        XCTAssertEqual(plantUMLElement, "class \"aStruct\" as aStruct << (S, SkyBlue) struct >> { \n  computedVariable : String \n}")
    }

    func testStructureShowGenerics() {
        let cut = SyntaxStructure.create(from: "struct aStruct <Title: View> {}")
        let plantUMLElement = cut?.find(.struct, named: "aStruct")?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showGenerics: true))))
        XCTAssertTrue(plantUMLElement!.contains("<Title: View>"))
    }

    func testStructureHideGenerics() {
        let cut = SyntaxStructure.create(from: "struct aStruct <Title: View> {}")
        let plantUMLElement = cut?.find(.struct, named: "aStruct")?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showGenerics: false))))
        XCTAssertFalse(plantUMLElement!.contains("<Title: View>"))
    }

    func testStructureNoTypeInference() {
        let cut = try! SyntaxStructure.create(from: getTestFile(), sdkPath: "IncorrectSdkPath")
        let plantUMLElement = cut?.find(.class, named: "Bicycle")?.plantuml(context: PlantUMLContext())
        XCTAssertFalse(plantUMLElement!.contains("~hasBasket : Bool"))
    }

    func testStructureTypeInference() {
        let cut = try! SyntaxStructure.create(from: getTestFile(), sdkPath: "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk")
        let plantUMLElement = cut?.find(.class, named: "Bicycle")?.plantuml(context: PlantUMLContext())
        XCTAssertTrue(plantUMLElement!.contains("~hasBasket : Bool"))
    }

    func testOrderedByExtensionsLast() {
        let ext1 = SyntaxStructure(kind: .extension, name: "Ext1")
        let p1 = SyntaxStructure(kind: .protocol, name: "Protocol1")
        let c1 = SyntaxStructure(kind: .class, name: "Class1")
        let ext2 = SyntaxStructure(kind: .extension, name: "Ext2")
        let c2 = SyntaxStructure(kind: .class, name: "Class2")

        let unordered = [ext1, p1, c1, ext2, c2]
        let ordered = unordered.orderedByExtensionsLast()
        XCTAssertEqual(ordered, [p1, c1, c2, ext1, ext2])
    }

    func getTestFile() throws -> URL {
        // https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
        let path = Bundle.module.path(forResource: "demo", ofType: "txt", inDirectory: "TestData") ?? "nonesense"
        return URL(fileURLWithPath: path)
    }
}
