import Foundation

extension ElementAccessibility {
    var indicator: String? {
        switch self {
        case .public, .open:
            return "+"
        case .internal:
            return "~"
        case .private, .fileprivate:
            return "-"
        default:
            return nil
        }
    }
}

extension Optional where Wrapped == ElementAccessibility {
    var indicator: String? {
        switch self {
        case let .some(accessLevel):
            return accessLevel.indicator
        case .none:
            return "~"
        }
    }
}
