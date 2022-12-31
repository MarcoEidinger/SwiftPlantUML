import Foundation

extension SyntaxStructure {
    /// textual representation of Element in PlantUML scripting
    func plantuml(context: PlantUMLContext) -> String? {
        guard let kind = kind else { return nil }

        guard skip(element: self, basedOn: context.configuration) == false else { return nil }

        var generics: String?
        if context.configuration.elements.showGenerics {
            generics = genericsStatement()
        }

        var textualRepresentation = ""
        // swiftlint:disable line_length
        switch kind {
        case ElementKind.class:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "inherits"))\(generics ?? "") \(context.configuration.stereotypes.class?.plantuml ?? Stereotype.class.plantuml) { \(members(context: context)) \n}"
        case ElementKind.struct:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "inherits"))\(generics ?? "") \(context.configuration.stereotypes.struct?.plantuml ?? Stereotype.struct.plantuml) { \(members(context: context)) \n}"
        case ElementKind.extension:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "ext"))\(generics ?? "") \(context.configuration.stereotypes.extension?.plantuml ?? Stereotype.extension.plantuml) { \(members(context: context)) \n}"
        case ElementKind.enum:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: ""))\(generics ?? "") \(context.configuration.stereotypes.enum?.plantuml ?? Stereotype.enum.plantuml) { \(members(context: context)) \n}"
        case ElementKind.protocol:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "confirms to"))\(generics ?? "") \(context.configuration.stereotypes.protocol?.plantuml ?? Stereotype.protocol.plantuml) { \(members(context: context)) \n}"
        default:
            Logger.shared.error("not supported")
            return nil
        }
        // swiftlint:enable line_length
        addLinking(context: context)
        return textualRepresentation
    }

    private func addLinking(context: PlantUMLContext) {
        if inheritedTypes != nil, inheritedTypes!.count > 0 {
            inheritedTypes!.forEach { parent in
                context.addLinking(item: self, parent: parent)
            }
        }
    }

    private func members(context: PlantUMLContext) -> String {
        var members = ""

        guard let substructure = substructure, substructure.count > 0 else { return members }

        for sub in substructure {
            if let msig = member(element: sub, context: context) {
                members.appendAsNewLine(msig)
            }
        }

        return members
    }

    private func member(element: SyntaxStructure, context: PlantUMLContext) -> String? {
        guard
            element.kind == ElementKind.functionMethodInstance ||
            element.kind == ElementKind.functionMethodStatic ||
            element.kind == ElementKind.varInstance ||
            element.kind == ElementKind.varStatic ||
            element.kind == ElementKind.enumcase else { return nil }

        let actualElement: SyntaxStructure!
        if element.kind == ElementKind.enumcase {
            actualElement = element.substructure?.first!
        } else {
            actualElement = element
        }

        if kind! != .extension {
            let generateMembersWithAccessLevel: [ElementAccessibility] = context.configuration.elements.showMembersWithAccessLevel.map { ElementAccessibility(orig: $0)! }
            if generateMembersWithAccessLevel.contains(actualElement.accessibility ?? ElementAccessibility.other) == false {
                return nil
            }
        }

        var msig = "  "

        msig.addOrSkipMemberAccessLevelAttribute(for: actualElement, basedOn: context.configuration)

        msig += memberName(of: actualElement)

        return msig
    }

    private func memberName(of element: SyntaxStructure) -> String {
        let kind = element.kind!
        switch kind {
        case .functionMethodInstance:
            return "\(element.name!)"
        case .functionMethodStatic:
            return "{static} \(element.name!)"
        case .varInstance:
            if element.typename != nil {
                return "\(element.name!) : \(element.typename!)"
            } else {
                return "\(element.name!)"
            }
        case .varStatic:
            if element.typename != nil {
                return "{static} \(element.name!) : \(element.typename!)"
            } else {
                return "{static} \(element.name!)"
            }
        case .enumelement:
            return "\(element.name!)"
        default:
            return ""
        }
    }

    private func skip(element: SyntaxStructure, basedOn configuration: Configuration) -> Bool {
        guard skip(element: self, basedOn: configuration.elements.exclude) == false else { return true }

        guard let elementKind = element.kind else { return true }

        if elementKind != .extension {
            let generateElementsWithAccessLevel: [ElementAccessibility] = configuration.elements.havingAccessLevel.map { ElementAccessibility(orig: $0)! }
            guard generateElementsWithAccessLevel.contains(accessibility ?? ElementAccessibility.other) else { return true }
        }

        if configuration.elements.showExtensions == false, kind == .extension {
            return true
        }

        return false
    }

    private func skip(element: SyntaxStructure, basedOn excludeElements: [String]?) -> Bool {
        guard let elementName = element.name else { return false }
        guard let excludedElements = excludeElements else { return false }
        return !excludedElements.filter { elementName.isMatching(searchPattern: $0) }.isEmpty
    }

    private func genericsStatement() -> String? {
        guard let substructure = substructure else { return nil }
        let params = substructure.filter { $0.kind == SwiftPlantUMLFramework.ElementKind.genericTypeParam }
        var genParts: [String] = []
        for param in params {
            guard let name = param.name else { continue }
            if let typeName = param.inheritedTypes?[0].name {
                genParts.append("\(name): \(typeName)")
            } else {
                genParts.append("\(name)")
            }
        }
        let genStatemnet = genParts.joined(separator: "\\n")
        guard genStatemnet.count > 0 else { return nil }
        return "<\(genStatemnet)>"
    }
}
