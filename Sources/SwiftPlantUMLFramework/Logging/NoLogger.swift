import Foundation

/// :nodoc:
struct NoLogger: Logging {
    /// :nodoc:
    internal init() {}

    /// :nodoc:
    public func error(_: String, _: String = #file, _: String = #function, _: Int = #line) {}

    /// :nodoc:
    public func warning(_: String, _: String = #file, _: String = #function, _: Int = #line) {}

    /// :nodoc:
    public func info(_: String, _: String = #file, _: String = #function, _: Int = #line) {}

    /// :nodoc:
    public func debug(_: String, _: String = #file, _: String = #function, _: Int = #line) {}
}
