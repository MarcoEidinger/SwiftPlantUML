class aClass: aProtocol {
    var computedProperty: String { "" }
    func aFunction() {}
}

protocol aProtocol {
    func aProtFunction() -> String
}

extension aProtocol {
    func aProtFunction() -> String { "" }
}

extension aClass {
    var anotherComputedProperty: String { "" }
    func anotherFunction() {}
}
