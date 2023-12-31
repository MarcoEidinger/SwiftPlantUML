@testable import SwiftPlantUMLFramework
import XCTest

final class ElementAccessibilityTests: XCTestCase {
    func testComparison() {
        XCTAssertTrue(ElementAccessibility.open > ElementAccessibility.public)
        XCTAssertTrue(ElementAccessibility.public > ElementAccessibility.package)
        XCTAssertTrue(ElementAccessibility.public > ElementAccessibility.internal)
        XCTAssertTrue(ElementAccessibility.public > ElementAccessibility.private)
        XCTAssertTrue(ElementAccessibility.package > ElementAccessibility.internal)
        XCTAssertTrue(ElementAccessibility.internal > ElementAccessibility.private)
        XCTAssertTrue(ElementAccessibility.private > ElementAccessibility.fileprivate)
        XCTAssertTrue(ElementAccessibility.private > ElementAccessibility.other)
        XCTAssertTrue(ElementAccessibility.fileprivate > ElementAccessibility.other)
    }

    func testIndicator() {
        XCTAssertEqual(ElementAccessibility.open.indicator, "+")
        XCTAssertEqual(ElementAccessibility.public.indicator, "+")
        XCTAssertEqual(ElementAccessibility.package.indicator, "~")
        XCTAssertEqual(ElementAccessibility.internal.indicator, "~")
        XCTAssertEqual(ElementAccessibility(orig: .internal)?.indicator, "~")
        XCTAssertEqual(ElementAccessibility.private.indicator, "-")
        XCTAssertEqual(ElementAccessibility(rawValue: "invalid").indicator, nil)
    }
}
