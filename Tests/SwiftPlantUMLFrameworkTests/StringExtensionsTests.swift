@testable import SwiftPlantUMLFramework
import XCTest

final class StringExtensionsTests: XCTestCase {
    func testRemoveAngleBracketsWithContent() {
        XCTAssertEqual("A<U>".removeAngleBracketsWithContent(), "A")
        XCTAssertEqual("A<U: View, T: View>".removeAngleBracketsWithContent(), "A")
        XCTAssertEqual("Handler<Void, [SelectedTenant]>".removeAngleBracketsWithContent(), "Handler")
    }

    func testExtractsContentInAngleBrackets() {
        XCTAssertEqual("Hello, <[World]>".getAngleBracketsWithContent(), "<[World]>")
        XCTAssertEqual("Hello, <<[World]>>".getAngleBracketsWithContent(), "<<[World]>>")
        XCTAssertNil("Hello, World!".getAngleBracketsWithContent())
        XCTAssertNil("Hello, <World!".getAngleBracketsWithContent())
        XCTAssertNil("Hello, World!>".getAngleBracketsWithContent())
    }

    func testIsMatching() {
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "PlantUML*"), true)
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "*Name"), true)
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "*Class*"), true)
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "PlantUMLClassName"), true)
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "*Plant*"), true)
        XCTAssertEqual("PlantUMLClassName".isMatching(searchPattern: "ClassName"), false)
    }
}
