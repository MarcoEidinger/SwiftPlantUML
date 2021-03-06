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
}

/// common interface for Loggers
public protocol Logging {
    /// log an error
    /// - Parameters:
    ///   - message: to be logged
    ///   - file: in which the message occurred
    ///   - function: in wich the message occurred
    ///   - line: line number in which the message occurred
    /// - Parameter message: to be logged
    func error(_ message: String, _ file: String, _ function: String, _ line: Int)

    /// log a warning
    /// - Parameters:
    ///   - message: to be logged
    ///   - file: in which the message occurred
    ///   - function: in wich the message occurred
    ///   - line: line number in which the message occurred
    func warning(_ message: String, _ file: String, _ function: String, _ line: Int)

    /// log an info
    /// - Parameters:
    ///   - message: to be logged
    ///   - file: in which the message occurred
    ///   - function: in wich the message occurred
    ///   - line: line number in which the message occurred
    func info(_ message: String, _ file: String, _ function: String, _ line: Int)

    /// log debugging-related info
    /// - Parameters:
    ///   - message: to be logged
    ///   - file: in which the message occurred
    ///   - function: in wich the message occurred
    ///   - line: line number in which the message occurred
    func debug(_ message: String, _ file: String, _ function: String, _ line: Int)
}

/// :nodoc:
public extension Logging {
    /// :nodoc:
    func error(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        error(message, file, function, line)
    }

    /// :nodoc:
    func warning(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        warning(message, file, function, line)
    }

    /// :nodoc:
    func info(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        info(message, file, function, line)
    }

    /// :nodoc:
    func debug(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        debug(message, file, function, line)
    }
}

/// :nodoc:
public enum Logger {
    /// singleton to access logger througout the SwiftPlantUMLFramework
    public static var shared: Logging = NoLogger()
}
