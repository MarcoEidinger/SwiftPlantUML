import Foundation

/// defines a unified interface for presenting a PlantUML script / diagram
public protocol PlantUMLPresenting {
    /// present script / diagram to user
    /// - Parameters:
    ///   - script: in PlantUML notation
    ///   - completionHandler: has to be called when presentation was triggered
    func present(script: PlantUMLScript, completionHandler: @escaping () -> Void)
}
