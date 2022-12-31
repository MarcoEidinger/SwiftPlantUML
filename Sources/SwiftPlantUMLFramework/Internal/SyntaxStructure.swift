import Foundation

/// Swift type representationg an AST element (analogue to SourceKitten's Structure)
internal struct SyntaxStructure: Codable {
    internal init(accessibility: ElementAccessibility? = nil, attribute: String? = nil, attributes: [SyntaxStructure]? = nil, elements: [SyntaxStructure]? = nil, inheritedTypes: [SyntaxStructure]? = nil, kind: ElementKind? = nil, name: String? = nil, runtimename: String? = nil, substructure: [SyntaxStructure]? = nil, typename: String? = nil) {
        self.accessibility = accessibility
        self.attribute = attribute
        self.attributes = attributes
        self.elements = elements
        self.inheritedTypes = inheritedTypes
        self.kind = kind
        self.name = name
        self.runtimename = runtimename
        self.substructure = substructure
        self.typename = typename
    }

    /// access level
    internal let accessibility: ElementAccessibility?
    private let attribute: String?
    private let attributes: [SyntaxStructure]?
    private let elements: [SyntaxStructure]?
    /// inheritedTypes (e..g superclass)
    internal let inheritedTypes: [SyntaxStructure]?
    /// declaration kind
    internal let kind: ElementKind?
    /// name
    internal let name: String?
    /// name
    private let runtimename: String?
    /// sub elements (e.g. variables and methods of a class/struct)
    internal let substructure: [SyntaxStructure]?
    /// typename
    internal let typename: String?

    private enum CodingKeys: String, CodingKey {
        case accessibility = "key.accessibility"
        case attribute = "key.attribute"
        case attributes = "key.attributes"
        case elements = "key.elements"
        case inheritedTypes = "key.inheritedtypes"
        case kind = "key.kind"
        case name = "key.name"
        case runtimename = "key.runtime_name"
        case substructure = "key.substructure"
        case typename = "key.typename"
    }

    internal func find(_ type: ElementKind = .struct, named searchName: String) -> SyntaxStructure? {
        if name == searchName, kind == type {
            return self
        } else {
            guard let subs = substructure else { return nil }
            for sub in subs {
                if let found = sub.find(type, named: searchName) {
                    return found
                }
            }
        }
        return nil
    }
}

protocol UnknownCaseRepresentable: RawRepresentable, CaseIterable where RawValue: Equatable {
    /// `unknownCase` (abnormal situation)
    static var unknownCase: Self { get }
}

extension UnknownCaseRepresentable {
    public init(rawValue: RawValue) {
        let value = Self.allCases.first(where: { $0.rawValue == rawValue })
        self = value ?? Self.unknownCase
    }
}

///
internal enum ElementAccessibility: String, RawRepresentable, Comparable {
    internal static func < (lhs: ElementAccessibility, rhs: ElementAccessibility) -> Bool {
        lhs.value < rhs.value
    }

    /// `open`
    case open = "source.lang.swift.accessibility.open"
    /// `public`
    case `public` = "source.lang.swift.accessibility.public"
    /// `internal`
    case `internal` = "source.lang.swift.accessibility.internal"
    /// `private`
    case `private` = "source.lang.swift.accessibility.private"
    /// `fileprivate`
    case `fileprivate` = "source.lang.swift.accessibility.fileprivate"
    /// `other` (abnormal situation)
    case other

    private var value: Int {
        switch self {
        case .open:
            return 6
        case .public:
            return 5
        case .internal:
            return 4
        case .private:
            return 3
        case .fileprivate:
            return 2
        case .other:
            return 1
        }
    }

    internal init?(orig: AccessLevel) {
        switch orig {
        case .open:
            self.init(rawValue: "source.lang.swift.accessibility.open")
        case .public:
            self.init(rawValue: "source.lang.swift.accessibility.public")
        case .internal:
            self.init(rawValue: "source.lang.swift.accessibility.internal")
        case .private:
            self.init(rawValue: "source.lang.swift.accessibility.private")
        case .fileprivate:
            self.init(rawValue: "source.lang.swift.accessibility.fileprivate")
        }
    }
}

extension ElementAccessibility: Codable {}

extension ElementAccessibility: UnknownCaseRepresentable {
    /// `unknownCase` (abnormal situation)
    static let unknownCase: ElementAccessibility = .other
}

// https://github.com/jpsim/SourceKitten/blob/master/Source/SourceKittenFramework/SwiftDeclarationKind.swift
/// Identifical to SourceKittenFramework's `SwiftDeclarationKind`
internal enum ElementKind: String, RawRepresentable {
    /// `associatedtype`.
    case `associatedtype` = "source.lang.swift.decl.associatedtype"
    /// `class`.
    case `class` = "source.lang.swift.decl.class"
    /// `enum`.
    case `enum` = "source.lang.swift.decl.enum"
    /// `enumcase`.
    case enumcase = "source.lang.swift.decl.enumcase"
    /// `enumelement`.
    case enumelement = "source.lang.swift.decl.enumelement"
    /// `extension`.
    case `extension` = "source.lang.swift.decl.extension"
    /// `extension.class`.
    case extensionClass = "source.lang.swift.decl.extension.class"
    /// `extension.enum`.
    case extensionEnum = "source.lang.swift.decl.extension.enum"
    /// `extension.protocol`.
    case extensionProtocol = "source.lang.swift.decl.extension.protocol"
    /// `extension.struct`.
    case extensionStruct = "source.lang.swift.decl.extension.struct"
    /// `function.accessor.address`.
    case functionAccessorAddress = "source.lang.swift.decl.function.accessor.address"
    /// `function.accessor.didset`.
    case functionAccessorDidset = "source.lang.swift.decl.function.accessor.didset"
    /// `function.accessor.getter`.
    case functionAccessorGetter = "source.lang.swift.decl.function.accessor.getter"
    /// `function.accessor.modify`
    //    @available(swift, introduced: 5.0)
    case functionAccessorModify = "source.lang.swift.decl.function.accessor.modify"
    /// `function.accessor.mutableaddress`.
    case functionAccessorMutableaddress = "source.lang.swift.decl.function.accessor.mutableaddress"
    /// `function.accessor.read`
    //    @available(swift, introduced: 5.0)
    case functionAccessorRead = "source.lang.swift.decl.function.accessor.read"
    /// `function.accessor.setter`.
    case functionAccessorSetter = "source.lang.swift.decl.function.accessor.setter"
    /// `function.accessor.willset`.
    case functionAccessorWillset = "source.lang.swift.decl.function.accessor.willset"
    /// `function.constructor`.
    case functionConstructor = "source.lang.swift.decl.function.constructor"
    /// `function.destructor`.
    case functionDestructor = "source.lang.swift.decl.function.destructor"
    /// `function.free`.
    case functionFree = "source.lang.swift.decl.function.free"
    /// `function.method.class`.
    case functionMethodClass = "source.lang.swift.decl.function.method.class"
    /// `function.method.instance`.
    case functionMethodInstance = "source.lang.swift.decl.function.method.instance"
    /// `function.method.static`.
    case functionMethodStatic = "source.lang.swift.decl.function.method.static"
    /// `function.operator`.
    //    @available(swift, obsoleted: 2.2)
    case functionOperator = "source.lang.swift.decl.function.operator"
    /// `function.operator.infix`.
    case functionOperatorInfix = "source.lang.swift.decl.function.operator.infix"
    /// `function.operator.postfix`.
    case functionOperatorPostfix = "source.lang.swift.decl.function.operator.postfix"
    /// `function.operator.prefix`.
    case functionOperatorPrefix = "source.lang.swift.decl.function.operator.prefix"
    /// `function.subscript`.
    case functionSubscript = "source.lang.swift.decl.function.subscript"
    /// `generic_type_param`.
    case genericTypeParam = "source.lang.swift.decl.generic_type_param"
    /// `module`.
    case module = "source.lang.swift.decl.module"
    /// `opaquetype`.
    case opaqueType = "source.lang.swift.decl.opaquetype"
    /// `precedencegroup`.
    case precedenceGroup = "source.lang.swift.decl.precedencegroup"
    /// `protocol`.
    case `protocol` = "source.lang.swift.decl.protocol"
    /// `struct`.
    case `struct` = "source.lang.swift.decl.struct"
    /// `typealias`.
    case `typealias` = "source.lang.swift.decl.typealias"
    /// `var.class`.
    case varClass = "source.lang.swift.decl.var.class"
    /// `var.global`.
    case varGlobal = "source.lang.swift.decl.var.global"
    /// `var.instance`.
    case varInstance = "source.lang.swift.decl.var.instance"
    /// `var.local`.
    case varLocal = "source.lang.swift.decl.var.local"
    /// `var.parameter`.
    case varParameter = "source.lang.swift.decl.var.parameter"
    /// `var.static`.
    case varStatic = "source.lang.swift.decl.var.static"
    /// `other` (abnormal situation)
    case other
}

extension ElementKind: Codable {}

extension ElementKind: UnknownCaseRepresentable {
    /// `unknownCase` (abnormal situation)
    static let unknownCase: ElementKind = .other
}
