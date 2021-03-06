@testable import SwiftPlantUMLFramework
import XCTest

final class LoggerTests: XCTestCase {
    func testSharedLogger() {
        XCTAssertNotNil(Logger.shared)
    }

    func testNoLogger() {
        let nl = NoLogger()
        XCTAssertNotNil(nl)
        nl.error("---")
        nl.warning("---")
        nl.info("---")
    }
}
