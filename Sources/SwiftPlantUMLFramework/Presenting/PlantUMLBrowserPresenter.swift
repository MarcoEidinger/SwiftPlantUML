import Cocoa
import Foundation

/// presentation formats supported to render PlantUML scripts in browser
public enum BrowserPresentationFormat {
    /// image only (as .png)
    case imagePng
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
        script.encodedText { result in
            switch result {
            case let .success(encodedText):
                let url: URL!
                switch format {
                case .imagePng:
                    url = URL(string: "https://www.planttext.com/api/plantuml/png/\(encodedText)")
                default:
                    url = URL(string: "https://www.planttext.com/?text=\(encodedText)")!
                }
                NSWorkspace.shared.open(url)
                completionHandler()
            case .failure:
                completionHandler()
            }
        }
    }
}
