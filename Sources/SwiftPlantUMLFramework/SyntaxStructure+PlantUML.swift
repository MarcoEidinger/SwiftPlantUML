import Foundation

extension SyntaxStructure {
    /// textual representation of Element in PlantUML scripting
    func plantuml(context: PlantUMLContext) -> String? {
        guard let kind = kind else { return nil }
        if kind != .extension {
            guard context.elementsAccesToShow.contains(accessibility ?? ElementAccessibility.other) else {
                return nil
            }
        }

        var textualRepresentation: String = ""
        switch kind {
        case ElementKind.class:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "inherits")) { \(members(context: context)) \n}"
        case ElementKind.struct:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "inherits")) \(PlantUMLDefaultStyle.struct.rawValue) { \(members(context: context)) \n}"
        case ElementKind.extension:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "ext")) \(PlantUMLDefaultStyle.extension.rawValue) { \(members(context: context)) \n}"
        case ElementKind.enum:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "")) \(PlantUMLDefaultStyle.enum.rawValue) { \(members(context: context)) \n}"
        case ElementKind.protocol:
            textualRepresentation = "class \"\(name!)\" as \(context.uniqName(item: self, relationship: "confirms to")) \(PlantUMLDefaultStyle.protocol.rawValue) { \(members(context: context)) \n}"
        default:
            print("not supported")
            return nil
        }
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

        if substructure != nil, substructure!.count > 0 {
            for sub in substructure! {
                if sub.kind == ElementKind.functionMethodInstance || sub.kind == ElementKind.functionMethodStatic || sub.kind == ElementKind.varInstance ||
                    sub.kind == ElementKind.varStatic
                {
                    if kind! != .extension {
                        if context.membersAccesToShow.contains(sub.accessibility ?? ElementAccessibility.other) == false {
                            continue
                        }
                    }

                    var msig = "  "
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
            }
        }
        return methods
    }
}
