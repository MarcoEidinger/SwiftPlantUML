@testable import SwiftPlantUMLFramework
import XCTest

final class ElementAccessibilityTests: XCTestCase {
    func testComparison() {
        XCTAssertTrue(ElementAccessibility.open > ElementAccessibility.public)
        XCTAssertTrue(ElementAccessibility.public > ElementAccessibility.internal)
        XCTAssertTrue(ElementAccessibility.public > ElementAccessibility.private)
        XCTAssertTrue(ElementAccessibility.internal > ElementAccessibility.private)
        XCTAssertTrue(ElementAccessibility.private > ElementAccessibility.other)
    }
}
