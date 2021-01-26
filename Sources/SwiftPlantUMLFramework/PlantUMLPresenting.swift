import Foundation

/// defines a unified interface for presenting a PlantUML script / diagram
public protocol PlantUMLPresenting {
    /// present script / diagram to user
    func present(script: PlantUMLScript, completionHandler: @escaping () -> Void)
}
