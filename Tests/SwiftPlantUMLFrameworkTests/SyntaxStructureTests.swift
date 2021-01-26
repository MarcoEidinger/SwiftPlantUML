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

    func getTestFile() throws -> URL {
        // https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
        let path = Bundle.module.path(forResource: "demo", ofType: "txt", inDirectory: "TestData") ?? "nonesense"
        return URL(fileURLWithPath: path)
    }
}
