import Foundation
import XCTest

enum TestResources {
    static var path: String {
        URL(fileURLWithPath: #file)
            .deletingLastPathComponent()
            .appendingPathComponent("TestData")
            .path
            .absolutePathStandardized()
    }
}

extension String {
    func absolutePathStandardized() -> String {
        bridge().absolutePathRepresentation().bridge().standardizingPath
    }

    func stringByAppendingPathComponent(_ pathComponent: String) -> String {
        bridge().appendingPathComponent(pathComponent)
    }
}
