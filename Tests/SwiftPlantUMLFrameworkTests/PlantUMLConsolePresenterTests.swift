@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLConsolePresenterTests: XCTestCase {
    func testPresenting() {
        let expectation = self.expectation(description: "Print in Console")
        let presenter = PlantUMLConsolePresenter()
        presenter.present(script: PlantUMLScript(items: []), completionHandler: {
            XCTAssertNotNil("completionhandler called")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}
