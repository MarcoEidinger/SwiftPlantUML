@testable import SwiftPlantUMLFramework
import XCTest

final class LoggerTests: XCTestCase {
    func testSharedLogger() {
        XCTAssertNotNil(Logger.shared)
    }

    func testConsoleLoggerQuit() {
        let cl = ConsoleLogger(verbose: false)
        XCTAssertEqual(cl.logLevel, .error)
        cl.error("--1")
        cl.warning("--2")
        cl.info("--3")
    }

    func testConsoleLoggerVerbose() {
        let cl = ConsoleLogger(verbose: true)
        XCTAssertEqual(cl.logLevel, .debug)
        cl.error("--1v")
        cl.warning("--2v")
        cl.info("--3v")
    }

    func testNoLogger() {
        let nl = NoLogger()
        XCTAssertNotNil(nl)
        nl.error("---")
        nl.warning("---")
        nl.info("---")
    }
}
