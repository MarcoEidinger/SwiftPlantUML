@testable import SwiftPlantUMLFramework
import XCTest

final class ConfigurationProviderTests: XCTestCase {
    func testDefault() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotNil(config)
    }

    func testNonExisting() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock").stringByAppendingPathComponent("Level1")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotNil(config)
    }

    func testCustomGood() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock/CustomConfigValid.yml")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotEqual(config.files.exclude, Configuration.default.files.exclude)
    }

    func testCustomBad1() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock/customConfigBadMissingKey.yml")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotNil(config)
    }

    func testCustomBad2() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock/customConfigBadDataCorrupt.yml")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotNil(config)
    }

    func testCustomBad3() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock/customConfigBadEmpty.txt")
        let config = ConfigurationProvider().getConfiguration(for: testDir)
        XCTAssertNotNil(config)
    }
}
