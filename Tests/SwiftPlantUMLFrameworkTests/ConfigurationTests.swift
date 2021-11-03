@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLConfigurationTests: XCTestCase {
    func testDefault() {
        let config = Configuration()
        XCTAssertEqual(config.elements.havingAccessLevel.count, 4)
        XCTAssertEqual(config.elements.showMembersWithAccessLevel.count, 4)
    }
}
