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

    func testWithConfig() {
        let generator = ClassDiagramGenerator()
        let config = Configuration(elements: ElementOptions(havingAccessLevel: [.public], showMembersWithAccessLevel: [.public]))
        generator.generate(for: [try! getTestFilePath()], with: config, presentedBy: MockPlantUMLPresenter())
        // generator.generate(for: [try! getTestFilePath()], with: config, presentedBy: PlantUMLBrowserPresenter())
    }

    func testFromString() {
        let generator = ClassDiagramGenerator()
        generator.generate(from: "struct Test {}", presentedBy: MockPlantUMLPresenterForTestFromString())
    }

    func getTestFilePath() throws -> String {
        // https://stackoverflow.com/questions/47177036/use-resources-in-unit-tests-with-swift-package-manager
        Bundle.module.path(forResource: "demo", ofType: "txt", inDirectory: "TestData") ?? "nonesense"
    }
}
