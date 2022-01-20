@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLTextTests: XCTestCase {
    func testRawValue() {
        let sut = PlantUMLText(rawValue: "test")
        XCTAssertEqual(sut.rawValue, "test")
    }

    func testEncoding() {
        let text = "@startuml\n\' STYLE START\nhide empty members\nskinparam shadowing false\n\' STYLE END\n\n\n\n\n@enduml"
        let expectedResult = "SoWkIImgAStDuL9N20w9z745aev18LmPcIcf2gcv1IML2hcfkKcfHSLSnTcPUGM9HOcv2iKPYIdvvPbvwGffYJd5gN2jhdukN23Wa9gN0ZGI00=="

        XCTAssertEqual(PlantUMLText(rawValue: text).encodedValue, expectedResult)
        XCTAssertEqual(PlantUMLText(rawValue: text).description, expectedResult)
    }

    func testDescription() {
        let text = "@startuml\n\' STYLE START\nhide empty members\nskinparam shadowing false\n\' STYLE END\n\n\n\n\n@enduml"
        let expectedResult = "SoWkIImgAStDuL9N20w9z745aev18LmPcIcf2gcv1IML2hcfkKcfHSLSnTcPUGM9HOcv2iKPYIdvvPbvwGffYJd5gN2jhdukN23Wa9gN0ZGI00=="

        XCTAssertEqual(PlantUMLText(rawValue: text).description, expectedResult)
    }
}
