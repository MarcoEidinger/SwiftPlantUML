import ArgumentParser
import Foundation
import SwiftPlantUMLFramework

struct SwiftPlantUML: ParsableCommand {
    // Customize your command's help and subcommands by implementing the
    // `configuration` property.
    static var configuration = CommandConfiguration(
        // Optional abstracts and discussions are used for help output.
        abstract: "A utility for generating PlantUML script(s) and resulting diagram(s) from Swift code",

        // Commands can define a version for automatic '--version' support.
        version: SwiftPlantUMLFramework.Version.current.value,

        // Pass an array to `subcommands` to set up a nested tree of subcommands.
        // With language support for type-level introspection, this could be
        // provided by automatically finding nested `ParsableCommand` types.
        subcommands: [ClassDiagram.self],

        // A default subcommand, when provided, is automatically selected if a
        // subcommand is not given on the command line.
        defaultSubcommand: ClassDiagram.self
    )
}
