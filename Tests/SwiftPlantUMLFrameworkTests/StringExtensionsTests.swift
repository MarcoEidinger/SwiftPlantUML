@testable import SwiftPlantUMLFramework
import XCTest

final class StringExtensionsTests: XCTestCase {
    func testRemoveAngleBracketsWithContent() {
        XCTAssertEqual("A<U>".removeSquareBracketsWithContent(), "A")
        XCTAssertEqual("A<U: View, T: View>".removeSquareBracketsWithContent(), "A")
    }
}
