@testable import SwiftPlantUMLFramework
import XCTest

final class StringExtensionsTests: XCTestCase {
    func testRemoveAngleBracketsWithContent() {
        XCTAssertEqual("A<U>".removeAngleBracketsWithContent(), "A")
        XCTAssertEqual("A<U: View, T: View>".removeAngleBracketsWithContent(), "A")
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
