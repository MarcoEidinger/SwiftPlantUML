import Foundation

/// Logger using the console (`print`)
public struct ConsoleLogger: Logging {
    /// logLevel (default: error) for which messages (equal or higher) will be logged
    public private(set) var logLevel: LogLevel

    /// default initializer
    public init(verbose: Bool) {
        logLevel = verbose ? .debug : .error
    }

    /// log an error
    /// - Parameter message: to be logged
    public func error(_ message: String) {
        guard logLevel >= .error else { return }
        print("\(LogLevel.error.coloredLevelWord) \(message)")
    }

    /// log a warning
    /// - Parameter message: to be logged
    public func warning(_ message: String) {
        guard logLevel >= .warning else { return }
        print("\(LogLevel.warning.coloredLevelWord) \(message)")
    }

    /// log an info
    /// - Parameter message: to be logged
    public func info(_ message: String) {
        guard logLevel >= .info else { return }
        print("\(LogLevel.info.coloredLevelWord) \(message)")
    }
}
