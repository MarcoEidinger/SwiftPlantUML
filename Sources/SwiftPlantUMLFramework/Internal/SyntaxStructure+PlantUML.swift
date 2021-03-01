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

        var textualRepresentation: String = ""
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
        var methods = ""

        guard substructure != nil, substructure!.count > 0 else { return methods }

        for sub in substructure! {
            guard sub.kind == ElementKind.functionMethodInstance || sub.kind == ElementKind.functionMethodStatic || sub.kind == ElementKind.varInstance ||
                sub.kind == ElementKind.varStatic else { continue }

            if kind! != .extension {
                let generateMembersWithAccessLevel: [ElementAccessibility] = context.configuration.elements.showMembersWithAccessLevel.map { ElementAccessibility(orig: $0)! }
                if generateMembersWithAccessLevel.contains(sub.accessibility ?? ElementAccessibility.other) == false {
                    continue
                }
            }

            var msig = "  "

            if context.configuration.elements.showMemberAccessLevelAttribute {
                switch sub.accessibility {
                case .public:
                    msig += "+"
                case .internal:
                    msig += "~"
                case .private:
                    msig += "-"
                default:
                    ()
                }
            }

            if sub.kind == ElementKind.functionMethodInstance {
                msig += "\(sub.name!)"
            }
            if sub.kind == ElementKind.functionMethodStatic {
                msig += "{static} \(sub.name!)"
            }
            if sub.kind == ElementKind.varInstance {
                if sub.typename != nil {
                    msig += "\(sub.name!) : \(sub.typename!)"
                } else {
                    msig += "\(sub.name!)"
                }
            }
            if sub.kind == ElementKind.varStatic {
                if sub.typename != nil {
                    msig += "{static} \(sub.name!) : \(sub.typename!)"
                } else {
                    msig += "{static} \(sub.name!)"
                }
            }

            methods.appendAsNewLine(msig)
        }

        return methods
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
