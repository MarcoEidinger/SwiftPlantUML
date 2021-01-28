@testable import SwiftPlantUMLFramework
import XCTest

struct MockPlantUMLPresenter: PlantUMLPresenting {
    func present(script _: PlantUMLScript, completionHandler: @escaping () -> Void) {
        XCTAssertNotNil("Presenter called")
        completionHandler()
    }
}

struct MockPlantUMLPresenterForTestFromString: PlantUMLPresenting {
    func present(script: PlantUMLScript, completionHandler: @escaping () -> Void) {
        XCTAssertTrue(script.text.contains("class \"Test\""))
        completionHandler()
    }
}

final class ClassDiagramGeneratorTests: XCTestCase {
    func testNofiles() {
        let generator = ClassDiagramGenerator()
        generator.generate(for: [], presentedBy: MockPlantUMLPresenter())
    }

    func testSingleFile() {
        let generator = ClassDiagramGenerator()
        generator.generate(for: ["./Tests/SwiftPlantUMLFrameworkTests/TestData/demo.txt"], presentedBy: MockPlantUMLPresenter())
    }

    func testDotAlias() {
        let generator = ClassDiagramGenerator()
        generator.generate(for: ["."], presentedBy: MockPlantUMLPresenter())
    }

    func testFromString() {
        let generator = ClassDiagramGenerator()
        generator.generate(from: "struct Test {}", presentedBy: MockPlantUMLPresenterForTestFromString())
    }
}
