import Foundation

/// print script in console
public struct PlantUMLConsolePresenter: PlantUMLPresenting {
    /// default initializer
    public init() {}

    public func present(script: PlantUMLScript, completionHandler: @escaping () -> Void) {
        print(script.text)
        completionHandler()
    }
}
