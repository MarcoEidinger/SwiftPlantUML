@testable import SwiftPlantUMLFramework
import XCTest

final class ColorTests: XCTestCase {
    func testNumberOfColors() {
        let colors = Color.allCases
        XCTAssertEqual(colors.count, 147)
    }
}
