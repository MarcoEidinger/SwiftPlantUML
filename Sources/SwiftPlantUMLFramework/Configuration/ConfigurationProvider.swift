import Foundation
import Yams

/// ConfigurationProvider to load `Configuration` from file or memory
public struct ConfigurationProvider {
    /// default initializer
    public init() {}

    /// search for configuration in the given path or the default location (.swiftplantuml) and return it
    /// - Parameter path: file path of configuration file
    /// - Returns: default `Configuration` instance if none was found
    public func getConfiguration(for path: String?) -> Configuration {
        guard let configPath = path else {
            return readSwiftConfig()
        }

        Logger.shared.info("search config file with custom location \(configPath)")
        let fileURL = URL(fileURLWithPath: configPath)
        if let config = decodeYml(config: fileURL) {
            Logger.shared.info("config file \(configPath) found")
            return config
        } else {
            return readSwiftConfig()
        }
    }

    func readSwiftConfig() -> Configuration {
        Logger.shared.info("search for config file in current directory with name '.swiftplantuml.yml'")
        if let config = decodeYml(config: defaultYmlPath) {
            Logger.shared.info(".swiftplantuml.yml file found")
            return config
        } else {
            Logger.shared.info("return default configuration")
            return defaultConfig
        }
    }

    var defaultYmlPath: URL {
        let dir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        return dir.appendingPathComponent(".swiftplantuml.yml")
        // return URL(fileURLWithPath: "/Users/d041771/git/__Private/SwiftPlantUML/.swiftplantuml.yml")
    }

    func decodeYml(config: URL) -> Configuration? {
        var encodedYAML: String!
        do {
            encodedYAML = try String(contentsOf: config, encoding: .utf8)
        } catch {
            Logger.shared.info("cannot find/read yaml file")
            return nil
        }

        do {
            let decoder = YAMLDecoder()
            return try decoder.decode(Configuration.self, from: encodedYAML)
        } catch {
            let decodingError = error as? DecodingError
            switch decodingError {
            case let .dataCorrupted(context):
                Logger.shared.error("invalid value for \(context.codingPath.map(\.stringValue).joined(separator: ".")) in \(config.path)")
            case let .keyNotFound(missingKey, _):
                Logger.shared.error("missing key \(missingKey.stringValue) in \(config.path)")
            default:
                Logger.shared.error("\(error.localizedDescription) in \(config.path)")
            }
            return nil
        }
    }

    var defaultConfig: Configuration {
        Configuration.default
    }
}
