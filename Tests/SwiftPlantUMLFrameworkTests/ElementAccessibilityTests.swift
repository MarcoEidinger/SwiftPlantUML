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

    func testIndicator() {
        XCTAssertEqual(ElementAccessibility.open.indicator, "+")
        XCTAssertEqual(ElementAccessibility.public.indicator, "+")
        XCTAssertEqual(ElementAccessibility.internal.indicator, "~")
        XCTAssertEqual(ElementAccessibility(orig: .internal)?.indicator, "~")
        XCTAssertEqual(ElementAccessibility.private.indicator, "-")
        XCTAssertEqual(ElementAccessibility(rawValue: "invalid").indicator, nil)
    }
}
