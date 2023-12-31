import SourceKittenFramework
@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLScriptTests: XCTestCase {
    func testNoItems() {
        let script = PlantUMLScript(items: [])
        XCTAssertTrue(script.text.contains("@startuml"))
        XCTAssertTrue(script.text.contains("' STYLE START"))
        XCTAssertTrue(script.text.contains("hide empty members"))
        XCTAssertTrue(script.text.contains("skinparam shadowing false"))
        XCTAssertTrue(script.text.contains("' STYLE END"))
        XCTAssertTrue(script.text.contains("@enduml"))

        XCTAssertFalse(script.text.contains("!include"))
    }

    func testEncodedScript() {
        let script = PlantUMLScript(items: [])
        XCTAssertEqual(script.encodeText(), "FOsn3i8m30LtVuKtVgD8T4CCj0kZ8QyqedQYs5N5tzCkt73RwJeFQR7gGYSUniUrtts-ZpJd18RM-B92dsXE_ibMfOcopvBAbktDaooEVzhVBkG8Db5ubHS6746KnbOCTD31qhxx0G==")
    }

    func testScriptWithInclude() {
        let script = PlantUMLScript(items: [], configuration: Configuration(includeRemoteURL: "https://anyInternetUrlToFile.com/example.txt"))
        XCTAssertTrue(script.text.contains("!include https://anyInternetUrlToFile.com/example.txt"))
    }

    func testScriptWithTheme() {
        let script = PlantUMLScript(items: [], configuration: Configuration(theme: Theme.cyborg))
        XCTAssertTrue(script.text.contains("!theme cyborg"))
    }

    func testScriptWithEmptyHideAndSkinCommands() {
        let script = PlantUMLScript(items: [], configuration: Configuration(hideShowCommands: [], skinparamCommands: []))
        XCTAssertFalse(script.text.contains("' STYLE START"))
        XCTAssertFalse(script.text.contains("' STYLE END"))
    }

    func testScriptWithCustomSkinCommands() {
        let script = PlantUMLScript(items: [], configuration: Configuration(skinparamCommands: ["skinparam classFontColor red"]))
        XCTAssertTrue(script.text.contains("' STYLE START"))
        XCTAssertTrue(script.text.contains("skinparam classFontColor red"))
        XCTAssertTrue(script.text.contains("' STYLE END"))

        XCTAssertFalse(script.text.contains("skinparam shadowing false"))
    }

    func testWithRootSyntaxStructure() {
        guard let item = try! SyntaxStructure.create(from: getTestFile()) else { return XCTFail("cannot read test data") }
        let script = PlantUMLScript(items: [item])
        let expected = """
        @startuml
        ' STYLE START
        hide empty members
        skinparam shadowing false
        ' STYLE END
        set namespaceSeparator none




        @enduml
        """
        XCTAssertEqual(script.text, expected)
    }

    func testWithRootsSubSyntaxStructure() {
        guard let items = try! SyntaxStructure.create(from: getTestFile())?.substructure else { return XCTFail("cannot read test data") }
        let config = Configuration(elements: ElementOptions(showNestedTypes: false))
        let script = PlantUMLScript(items: items, configuration: config)
        XCTAssertTrue(script.text.contains("aClass"))
        let expected = try! getTestFileContent(named: "basicsAsPlantUML")
        XCTAssertEqual(script.text.noSpacesAndNoLineBreaks, expected.noSpacesAndNoLineBreaks)
    }

    func testMergeExtensionsE2E() {
        guard let items = try! SyntaxStructure.create(from: getTestFile())?.substructure else { return XCTFail("cannot read test data") }
        var config = Configuration.default
        config.elements = ElementOptions(showExtensions: .merged)
        let script = PlantUMLScript(items: items, configuration: config)
        let expected = try! getTestFileContent(named: "basicsAsPlantUML-mergedExtensions")
        XCTAssertEqual(script.text.noSpacesAndNoLineBreaks, expected.noSpacesAndNoLineBreaks)
    }

    func testShowNestedTypesE2E() {
        guard let items = try! SyntaxStructure.create(from: getTestFile(named: "nestedTypes"))?.substructure else { return XCTFail("cannot read test data") }
        let script = PlantUMLScript(items: items)
        let expected = try! getTestFileContent(named: "nestedTypesAsPlantUML")
        XCTAssertEqual(script.text.noSpacesAndNoLineBreaks, expected.noSpacesAndNoLineBreaks)
    }

    func testShowNestedTypesMergedExtensionsE2E() {
        guard let items = try! SyntaxStructure.create(from: getTestFile(named: "nestedTypes"))?.substructure else { return XCTFail("cannot read test data") }
        var config = Configuration.default
        config.elements = ElementOptions(showExtensions: .merged)
        let script = PlantUMLScript(items: items, configuration: config)
        let expected = try! getTestFileContent(named: "nestedTypesMergedExtensionsAsPlantUML")
        XCTAssertEqual(script.text.noSpacesAndNoLineBreaks, expected.noSpacesAndNoLineBreaks)
    }

    func testIncludingPageTexts() {
        guard let items = try! SyntaxStructure.create(from: getTestFile())?.substructure else { return XCTFail("cannot read test data") }
        let headerText = "Header123"
        var config = Configuration.default
        config.texts = PageTexts(header: headerText)
        let script = PlantUMLScript(items: items, configuration: config)
        XCTAssertTrue(script.text.contains(headerText))
    }
    
    func testPackageAccessModifierE2E() {
        guard let items = try! SyntaxStructure.create(from: getTestFile(named: "packageAccessModifier"))?.substructure else { return XCTFail("cannot read test data") }
        let script = PlantUMLScript(items: items)
        let expected = try! getTestFileContent(named: "packageAccessModifierAsPlantUML")
        XCTAssertEqual(script.text.noSpacesAndNoLineBreaks, expected.noSpacesAndNoLineBreaks)
    }

    func getTestFile(named: String = "basics") throws -> URL {
        // https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
        let path = Bundle.module.path(forResource: named, ofType: "txt", inDirectory: "TestData") ?? "nonesense"
        return URL(fileURLWithPath: path)
    }

    func getTestFileContent(named: String = "basics") throws -> String {
        let path = Bundle.module.path(forResource: named, ofType: "txt", inDirectory: "TestData") ?? "nonesense"
        return try String(contentsOfFile: path)
    }
}

extension String {
    var noSpacesAndNoLineBreaks: String {
        String(filter { !" \n\t\r".contains($0) })
    }
}
