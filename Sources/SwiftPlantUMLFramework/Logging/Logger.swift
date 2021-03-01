import Foundation

/// A log level can be used to make logging conditional, e.g. only errors with log level `error` but log infos, warning and errors with log level `info`
public enum LogLevel: Comparable {
    /// error
    case error
    /// warning
    case warning
    /// info
    case info
    /// debug
    case debug

    internal var coloredLevelWord: String {
        let debug = "DEBUG   "
        let info = "INFO    "
        let warning = "WARNING "
        let error = "ERROR   "

        switch self {
        case .debug:
            return "\u{1B}[92m\(debug)\u{1B}[0m"
        case .info:
            return "\u{1B}[94m\(info)\u{1B}[0m"
        case .warning:
            return "\u{1B}[93m\(warning)\u{1B}[0m"
        case .error:
            return "\u{1B}[91m\(error)\u{1B}[0m"
        }
    }
}

/// common interface for Loggers
public protocol Logging {
    /// log an error
    /// - Parameter message: to be logged
    func error(_ message: String)
    /// log a warning
    /// - Parameter message: to be logged
    func warning(_ message: String)
    /// log an info
    /// - Parameter message: to be logged
    func info(_ message: String)
}

/// :nodoc:
public enum Logger {
    /// singleton to access logger througout the SwiftPlantUMLFramework
    public static var shared: Logging = NoLogger()
}
