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
        let plantUMLElement = found?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showExtensions: ExtensionVisualization.none))))
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
    
    func testStructureGenericsParent() {
        let code = """
         class Handler<T, S> {}
         class MyHandler: Handler<Int, String> {}
        """
        let cut = SyntaxStructure.create(from: code)
        let plantUMLElement = cut?.find(.class, named: "MyHandler")?.plantuml(context: PlantUMLContext(configuration: Configuration(elements: ElementOptions(showGenerics: true))))
        XCTAssertTrue(plantUMLElement!.contains(#"class "MyHandler" as MyHandler<Int, String>"#))
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
        let s1 = SyntaxStructure(kind: .struct, name: "Struct1")
        let ext2 = SyntaxStructure(kind: .extension, name: "Ext2")
        let c2 = SyntaxStructure(kind: .class, name: "Class2")
        let s2 = SyntaxStructure(kind: .struct, name: "Struct2")

        let unordered = [ext1, c1, p1, s1, ext2, c2, s2]
        let ordered = unordered.orderedByProtocolsFirstExtensionsLast()
        XCTAssertEqual(ordered, [p1, c1, s1, c2, s2, ext1, ext2])
    }

    func testMerged() {
        let c1 = SyntaxStructure(kind: .class, name: "Class", substructure: [.init(kind: .varInstance, name: "prop")])
        let ext1 = SyntaxStructure(kind: .extension, name: "Class", substructure: [.init(kind: .varInstance, name: "propExt1")])
        let ext2 = SyntaxStructure(kind: .extension, name: "Class", substructure: [.init(kind: .varInstance, name: "propExt2")])
        let merged = [c1, ext1, ext2].mergeExtensions()
        XCTAssertEqual(merged.count, 1)
        XCTAssertEqual(merged.first?.substructure?.count, 3)
    }

    func testMergedIntoParentWithNoMembers() {
        let c1 = SyntaxStructure(kind: .class, name: "Class", substructure: nil)
        let ext1 = SyntaxStructure(kind: .extension, name: "Class", substructure: [.init(kind: .varInstance, name: "propExt1")])
        let ext2 = SyntaxStructure(kind: .extension, name: "Class", substructure: [.init(kind: .varInstance, name: "propExt2")])
        let merged = [c1, ext1, ext2].mergeExtensions()
        XCTAssertEqual(merged.count, 1)
        XCTAssertEqual(merged.first?.substructure?.count, 2)
    }

    func testMergedAndNonMergableExtension() {
        let c1 = SyntaxStructure(kind: .class, name: "Class", substructure: [.init(kind: .varInstance, name: "prop")])
        let ext1 = SyntaxStructure(kind: .extension, name: "String", substructure: [.init(kind: .varInstance, name: "propExt1")])
        let merged = [c1, ext1].mergeExtensions()
        XCTAssertEqual(merged.count, 2)
        XCTAssertEqual(merged.first?.substructure?.count, 1)
    }

    func testMergedExt() {
        let ext1 = SyntaxStructure(kind: .extension, name: "String", substructure: [.init(kind: .varInstance, name: "propExt1")])
        let ext2 = SyntaxStructure(kind: .extension, name: "String", substructure: [.init(kind: .varInstance, name: "propExt2")])
        let merged = [ext1, ext2].mergeExtensions()
        XCTAssertEqual(merged.count, 1)
        XCTAssertEqual(merged.first?.substructure?.count, 2)
    }

    func testPopulateNestedTypes() {
        let p1 = SyntaxStructure(kind: .protocol, name: "aProt", substructure: [])
        let e1 = SyntaxStructure(kind: .enum, name: "MyEnum", substructure: [p1])
        let c2 = SyntaxStructure(kind: .class, name: "String", substructure: [e1])
        let c1 = SyntaxStructure(kind: .class, name: "String", substructure: [p1, c2])
        let merged = [c1].populateNestedTypes()
        XCTAssertEqual(merged.count, 3)
    }

    func getTestFile() throws -> URL {
        // https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
        let path = Bundle.module.path(forResource: "demo", ofType: "txt", inDirectory: "TestData") ?? "nonesense"
        return URL(fileURLWithPath: path)
    }
}
