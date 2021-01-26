import SourceKittenFramework
@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLScriptTests: XCTestCase {
    func testNoItemsAndNoStyle() {
        let script = PlantUMLScript(items: [], style: "")
        // print(script.text)
        let expected = """
        @startuml




        @enduml
        """
        XCTAssertEqual(script.text, expected)
    }

    func testNoItems() {
        let script = PlantUMLScript(items: [])
        let expected = """
        @startuml
        ' STYLE START
        hide empty members
        skinparam shadowing false
        ' STYLE END




        @enduml
        """
        XCTAssertEqual(script.text, expected)
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




        @enduml
        """
        XCTAssertEqual(script.text, expected)
    }

    func testWithRootsSubSyntaxStructure() {
        guard let items = try! SyntaxStructure.create(from: getTestFile())?.substructure else { return XCTFail("cannot read test data") }
        let script = PlantUMLScript(items: items)
        XCTAssertTrue(script.text.contains("aClass"))
        let expected = try! getTestFileContent(named: "basicsAsPlantUML")
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
