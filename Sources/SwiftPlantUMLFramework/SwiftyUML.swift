import Foundation

struct SwiftyUML {}

enum LinkTypeRelationship: String {
    case inheritance = "--|>"
    case realize = "..|>"
    case dependency = "<.."
    case association = "-->"
    case aggregation = "--o"
    case composition = "--*"
    case generic = "--"
}
