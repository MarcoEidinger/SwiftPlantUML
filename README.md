# SwiftPlantUML

Generate UML class diagrams from swift code with this Command Line Interface (CLI) and Swift Package.

[![Build Status](https://github.com/MarcoEidinger/SwiftPlantUML/workflows/Swift/badge.svg)](https://github.com/MarcoEidinger/SwiftPlantUML/workflows/Swift)
[![codecov](https://codecov.io/gh/MarcoEidinger/SwiftPlantUML/branch/main/graph/badge.svg?token=JOE7UL41JA)](https://codecov.io/gh/MarcoEidinger/SwiftPlantUML)
[![docs](https://marcoeidinger.github.io/SwiftPlantUML/badge.svg)](https://marcoeidinger.github.io/SwiftPlantUML/)
[![Xcode Extension](https://img.shields.io/badge/Xcode%20extension-available-brightgreen)](https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension)
[![Twitter](https://img.shields.io/badge/twitter-@MarcoEidinger-blue.svg)](http://twitter.com/MarcoEidinger)

Use one or more Swift files as input for a diagram to visualize `class`, `struct`, `protocol`, `enum` and `extension` types
with their instance and static members as well as their inheritance and implementation relationships

![Example Diagram](https://github.com/MarcoEidinger/SwiftPlantUML/raw/main/.assets/exampleDiagram.png)

## Usage

### Command Line

Example to generate and render diagram, based on a single Swift file, in your browser:

```
swiftplantuml ./Tests/SwiftPlantUMLFrameworkTests/TestData/basics.txt
```

Run `swiftplantuml` in the directory containing the Swift files to be considered for diagram generation. Directories
will be searched recursively.

```
$ swiftplantuml classdiagram --help
OVERVIEW: Generate PlantUML script and view it and diagram in browser

USAGE: swift-plant-uml classdiagram [<paths> ...] [--output <format>]

ARGUMENTS:
  <paths>                 List of paths to the files or directories containing
                          swift sources

OPTIONS:
  --output <format>       Defines output format. Options: browser,
                          browserImageOnly, consoleOnly (default: browser)
  --version               Show the version.
  -h, --help              Show help information.
```

As `classdiagram` is the default subcommand you can omit it.

### Swift package

```swift
dependencies: [
    .package(url: "https://github.com/MarcoEidinger/SwiftPlantUML.git", .upToNextMajor(from: "0.2.0"))
]
```

[API documentation](https://marcoeidinger.github.io/SwiftPlantUML/)

### Xcode source editor extension

See [MarcoEidinger/SwiftPlantUML-Xcode-Extension](https://github.com/MarcoEidinger/SwiftPlantUML-Xcode-Extension) for more details

## Installation

### Using [Homebrew](https://brew.sh/)

```
brew install MarcoEidinger/formulae/swiftplantuml
```
### Using [Mint](https://github.com/yonaskolb/mint):

```
$ mint install MarcoEidinger/SwiftPlantUML
```

### Installing from source:

You can also build and install from source by cloning this project and running
`make install` (Xcode 12 or later).

Manually
Run the following commands to build and install manually:

```
$ git clone https://github.com/MarcoEidinger/SwiftPlantUML.git
$ cd SwiftPlantUML
$ make install
```

## Planned improvements
- being able to render associations between elements
- being able to limit elements and members bases on their access level
- being able to merge extensions with their known type
- being able to configure styles and skin parameters

## Known limitations
- unknown type for variables declared with type inference (e.g. `var count = 0`)
  - this is a limitation of SourceKitten :(
- huge diagrams in browser
  - PlantUML limits image width and height to 4096 with the option to override this limit when using PlantUML.jar. locally so your option is to use the `--textonly`option and adjust/use it with PlantUML tools directly

## Acknowledgements

This project was inspired by https://github.com/palaniraja and its various predecessors. Out of personal preference I chose to start a new project. I wanted to provide a tool for Swift developers written in Swift! This will hopefully allow me and potential contributors to work on planned improvements faster and more efficient. 

Last but not least a big shoutout to the great developers of [PlantUML](https://github.com/plantuml/plantuml) and the people who operate the related online servers / tools available on http://plantuml.com/ and https://www.planttext.com/ 

