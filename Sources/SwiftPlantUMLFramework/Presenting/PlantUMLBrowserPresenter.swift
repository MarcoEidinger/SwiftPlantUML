import Cocoa
import Foundation

/// presentation formats supported to render PlantUML scripts in browser
public enum BrowserPresentationFormat {
    /// image only (as .png)
    @available(*, deprecated, message: "Use .png instead")
    case imagePng
    /// image only (as .png)
    case png
    /// image only (as .svg)
    case svg
    /// editable script and corresponding diagram
    case `default`
}

/// compress  diagram into an URL and launch in browser (PlantText server).
public struct PlantUMLBrowserPresenter: PlantUMLPresenting {
    /// format in which to present the script in the browser (default: editable script and corresponding diagram)
    public private(set) var format: BrowserPresentationFormat

    /// default initializer
    /// - Parameter format: in which to present the script in the browser
    public init(format: BrowserPresentationFormat = .default) {
        self.format = format
    }

    /// present script / diagram to user
    /// - Parameters:
    ///   - script: in PlantUML notation
    ///   - completionHandler: will be called when presentation was triggered
    public func present(script: PlantUMLScript, completionHandler: @escaping () -> Void) {
        let encodedText = script.encodeText()
        let url: URL!
        switch format {
        case .imagePng, .png:
            url = URL(string: "https://www.planttext.com/api/plantuml/png/\(encodedText)")
        case .svg:
            url = URL(string: "https://www.planttext.com/api/plantuml/svg/\(encodedText)")
        default:
            url = URL(string: "https://www.planttext.com/?text=\(encodedText)")!
        }
        NSWorkspace.shared.open(url)
        completionHandler()
    }
}
