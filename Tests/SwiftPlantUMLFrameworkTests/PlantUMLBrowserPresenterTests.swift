@testable import SwiftPlantUMLFramework
import XCTest

final class PlantUMLBrowserPresenterTests: XCTestCase {
    func testPresenting() throws {
        throw XCTSkip("Skip test as it is does not work in CI environment anymore")
        let expectation = self.expectation(description: "Open in Browser")
        let presenter = PlantUMLBrowserPresenter()
        presenter.present(script: PlantUMLScript(items: []), completionHandler: {
            XCTAssertNotNil("completionhandler called")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}
