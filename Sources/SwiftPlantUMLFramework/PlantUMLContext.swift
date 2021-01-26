import Foundation

enum PlantUMLDefaultStyle: String {
    case `struct` = "<< (S, SkyBlue) struct >>"
    case `extension` = "<< (E,orchid) extension >>"
    case `enum` = "<< (E,LightSteelBlue) enum >>"
    case `protocol` = "<< (P,GoldenRod) protocol >>"
}

class PlantUMLContext {
    var elementsAccesToShow: [ElementAccessibility] = [.public, .internal, .private]
    var membersAccesToShow: [ElementAccessibility] = [.public, .internal, .private]

    var uniqElementNames: [String] = []
    var uniqElementAndTypes: [String: String] = [:]
    // var style: [String: String] = [:]
    private(set) var connections: [String] = []
    private(set) var extnConnections: [String] = []

    private let linkTypeInheritance = "--|>"
    private let linkTypeRealize = "..|>"
    private let linkTypeDependency = "<.."
    private let linkTypeAssociation = "-->"
    private let linkTypeAggregation = "--o"
    private let linkTypeComposition = "--*"
    private let linkTypeGeneric = "--"

    var index = 0

    func addLinking(item: SyntaxStructure, parent: SyntaxStructure) {
        let linkTo = parent.name ?? "___"
        let namedConnection = (uniqElementAndTypes[linkTo] != nil) ? ": \(uniqElementAndTypes[linkTo] ?? "--ERROR--")" : ""
        var linkTypeKey = item.name! + "LinkType"

        if uniqElementAndTypes[linkTo] == "confirms to" {
            linkTypeKey = linkTo + "LinkType"
        }

        let connect = "\(item.name!) \(uniqElementAndTypes[linkTypeKey] ?? "--ERROR--") \(linkTo) \(namedConnection)"
        connections.append(connect)
    }

    func uniqName(item: SyntaxStructure, relationship: String) -> String {
        guard let name = item.name else { return "" }
        var newName = name
        let linkTypeKey = name + "LinkType"
        if uniqElementNames.contains(name) {
            newName += "\(index)"
            index += 1
            if item.kind == ElementKind.extension {
                let connect = "\(name) \(linkTypeDependency) \(newName) : \(relationship)"
                extnConnections.append(connect)
            }
        }
        // else if(item.kind == isSwiftExtension) {
        //     newName += `${index}`
        //     var connect = `${item.name} <.. ${newName} : ${relationship}`
        //     extnConnections.push(connect)
        // }
        else {
            uniqElementNames.append(name)
            uniqElementAndTypes[name] = relationship

            if relationship == "inherits" {
                uniqElementAndTypes[linkTypeKey] = linkTypeInheritance
            } else if relationship == "confirms to" {
                uniqElementAndTypes[linkTypeKey] = linkTypeRealize
            } else if relationship == "ext" {
                uniqElementAndTypes[linkTypeKey] = linkTypeDependency
            } else if relationship == "association" {
                uniqElementAndTypes[linkTypeKey] = linkTypeAssociation
            } else if relationship == "aggregation" {
                uniqElementAndTypes[linkTypeKey] = linkTypeAggregation
            } else if relationship == "composition" {
                uniqElementAndTypes[linkTypeKey] = linkTypeComposition
            } else {
                uniqElementAndTypes[linkTypeKey] = linkTypeGeneric
            }
        }
        return newName
    }
}
