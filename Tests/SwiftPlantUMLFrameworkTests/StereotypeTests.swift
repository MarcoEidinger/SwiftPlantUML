@testable import SwiftPlantUMLFramework
import XCTest

final class StereotypeTests: XCTestCase {
    func testDefaults() {
        XCTAssertEqual(Stereotype.class.spot.character, "C")
        XCTAssertEqual(Stereotype.struct.spot.character, "S")
        XCTAssertEqual(Stereotype.enum.spot.character, "E")
        XCTAssertEqual(Stereotype.extension.spot.character, "X")
        XCTAssertEqual(Stereotype.protocol.spot.character, "P")
    }

    func testEncodeStereotype() {
        XCTAssertNotNil(try! JSONEncoder().encode(Stereotype.class))
    }
}
