import Foundation

/// :nodoc:
struct NoLogger: Logging {
    /// :nodoc:
    internal init() {}

    /// :nodoc:
    public func error(_: String) {}

    /// :nodoc:
    public func warning(_: String) {}

    /// :nodoc:
    public func info(_: String) {}
}
