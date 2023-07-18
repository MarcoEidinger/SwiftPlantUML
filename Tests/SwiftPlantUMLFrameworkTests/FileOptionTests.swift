@testable import SwiftPlantUMLFramework
import XCTest

final class FileOptionsTests: XCTestCase {
    func testDescription() {
        XCTAssertEqual(FileOptions().description, "no values")
        XCTAssertEqual(FileOptions().description,  "no values")
        XCTAssertEqual(FileOptions(include: []).description,  "no values")
        XCTAssertEqual(FileOptions(include: ["one"]).description, "include: one")
        XCTAssertEqual(FileOptions(include: ["one", "two"]).description, "include: one, two")
        XCTAssertEqual(FileOptions(include: ["one", "two"], exclude: ["a"]).description, "include: one, two && exclude: a")
        XCTAssertEqual(FileOptions(include: ["one", "two"], exclude: ["a", "b"]).description, "include: one, two && exclude: a, b")
    }
}

