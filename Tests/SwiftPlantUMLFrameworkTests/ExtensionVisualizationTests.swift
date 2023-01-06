@testable import SwiftPlantUMLFramework
import XCTest

final class ExtensionVisualizationTests: XCTestCase {
    func testSafelyUnwrap() {
        let optionalDefault: ExtensionVisualization? = nil
        XCTAssertEqual(optionalDefault.safelyUnwrap, .all)
        
        let optionalMerged: ExtensionVisualization? = .merged
        XCTAssertEqual(optionalMerged.safelyUnwrap, .merged)
    }
}
