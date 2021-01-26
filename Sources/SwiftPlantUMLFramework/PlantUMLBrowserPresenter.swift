import Cocoa
import Foundation

/// compress  diagram into an URL and launch in browser (PlantText server).
public struct PlantUMLBrowserPresenter: PlantUMLPresenting {
    /// default initializer
    public init() {}

    public func present(script: PlantUMLScript, completionHandler: @escaping () -> Void) {
        script.asURL { result in
            switch result {
            case let .success(urlString):
                let url = URL(string: urlString)!
                NSWorkspace.shared.open(url)
                completionHandler()
            case .failure:
                completionHandler()
            }
        }
    }
}
