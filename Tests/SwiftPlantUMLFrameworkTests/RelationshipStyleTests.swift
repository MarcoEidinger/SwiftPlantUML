@testable import SwiftPlantUMLFramework
import XCTest

final class RelationshipStyleTests: XCTestCase {
    func testPlantUmlRepresentation() {
        let style = RelationshipStyle(lineStyle: .bold, lineColor: .AliceBlue, textColor: .Aqua)
        XCTAssertEqual(style.lineStyle, .bold)
        XCTAssertEqual(style.lineColor, .AliceBlue)
        XCTAssertEqual(style.textColor, .Aqua)
        XCTAssertEqual(style.plantuml, "#line:AliceBlue;line.bold;text:Aqua")
    }
}
