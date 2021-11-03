@testable import SwiftPlantUMLFramework
import XCTest

final class VersionTests: XCTestCase {
    func testCurrentVersion() {
        XCTAssertEqual(SwiftPlantUMLFramework.Version.current.value, "0.5.0")
    }
}
