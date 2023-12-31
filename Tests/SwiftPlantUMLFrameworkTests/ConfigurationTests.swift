@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLConfigurationTests: XCTestCase {
    func testDefault() {
        let config = Configuration()
        XCTAssertEqual(config.elements.havingAccessLevel.count, 5)
        XCTAssertEqual(config.elements.showMembersWithAccessLevel.count, 5)
    }

    func testDecodingObsoleteShowExtensionsBooleanProperty() {
        let config = """
        {"showExtensions":false}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.showExtensions, ExtensionVisualization.none)
    }

    func testDecodingNewExtensionsEnumProperty() {
        let config = """
        {"showExtensions":"merged"}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.showExtensions, .merged)
    }

    func testDecodingNewExtensionsEnumPropertyIncorrectValue() {
        let config = """
        {"showExtensions":"merge"}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.showExtensions, nil)
    }
}
