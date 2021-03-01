import Foundation

/// print script in console
public struct PlantUMLConsolePresenter: PlantUMLPresenting {
    /// default initializer
    public init() {}

    /// present script / diagram to user
    /// - Parameters:
    ///   - script: in PlantUML notation
    ///   - completionHandler: will to be called when presentation was triggered
    public func present(script: PlantUMLScript, completionHandler: @escaping () -> Void) {
        print(script.text)
        completionHandler()
    }
}
