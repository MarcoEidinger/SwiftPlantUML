@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLConfigurationTests: XCTestCase {
    func testDefault() {
        let config = Configuration()
        XCTAssertEqual(config.elements.havingAccessLevel.count, 4)
        XCTAssertEqual(config.elements.showMembersWithAccessLevel.count, 4)
    }

    func testDecodingObsoleteShowExtensionsBooleanProperty() {
        let config = """
        {"showExtensions":false}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.extensions, ExtensionVisualization.none)
    }

    func testDecodingNewExtensionsEnumProperty() {
        let config = """
        {"extensions":"merged"}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.extensions, .merged)
    }

    func testDecodingNewExtensionsEnumPropertyIncorrectValue() {
        let config = """
        {"extensions":"merge"}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.extensions, nil)
    }

    func testDecodingPrecedenceForNewExtensionsEnumProperty() {
        let config = """
        {"showExtensions":false,"extensions":"merged"}
        """
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        let content = try? decoder.decode(ElementOptions.self, from: data)
        XCTAssertEqual(content?.extensions, .merged)
    }
}
