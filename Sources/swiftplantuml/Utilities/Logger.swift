import Foundation
import SwiftPlantUMLFramework
import SwiftyBeaver

enum LogDestination {
    case console
    case file(URL)
}

struct BeaverLogger {
    private(set) var logLevel: LogLevel

    private(set) var log: SwiftyBeaver.Type

    init(into destination: LogDestination = .console, verbose: Bool) {
        logLevel = verbose ? .debug : .error

        log = SwiftyBeaver.self

        log.addDestination(make(destination))
    }

    func make(_ destination: LogDestination) -> BaseDestination {
        switch destination {
        case let .file(url):
            return FileDestination(logFileURL: url)
        default:
            return ConsoleDestination()
        }
    }

    static func create(verbose: Bool, classDiagramOutput: ClassDiagramOutput?) -> Logging {
        let logDesintation: LogDestination = (classDiagramOutput == .consoleOnly) ? .file(URL(fileURLWithPath: "/tmp/swiftplantuml.log")) : .console
        return BeaverLogger(into: logDesintation, verbose: verbose)
    }
}

extension BeaverLogger: Logging {
    public func error(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard logLevel >= .error else { return }
        log.error(message, file, function, line: line)
    }

    public func warning(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard logLevel >= .warning else { return }
        log.warning(message, file, function, line: line)
    }

    public func info(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard logLevel >= .info else { return }
        log.info(message, file, function, line: line)
    }

    public func debug(_ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard logLevel >= .debug else { return }
        log.debug(message, file, function, line: line)
    }
}
