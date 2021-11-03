## [0.5.0](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.4.0...0.5.0) (2021-11-03)

### ⚠ BREAKING CHANGES

* 🧨 `Open` elements and members will now be rendered while this was
previously not the case.
* 🧨 Change of order for elements and their inheritance/extensions relationships.
  * before: subclass points down to superclass
  * now: superclass on top and subclass points up to superclass
* 🧨 SwiftPlantUMLFramework drops its `ConsoleLogger` implementation. CLI is using `SwiftyBeaver` for logging.

### Features

* 🎸 support access level `open`
 ([a7597fc](https://github.com/MarcoEidinger/SwiftPlantUML/commit/a7597fc78695e08beb1da98bab61d67bedefb6c9)), closes [#23](https://github.com/MarcoEidinger/SwiftPlantUML/issues/23) 

## [0.4.0](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.3.0...0.4.0) (2021-03-05)

Enums are getting rendered with members (case elements, variables, functions) 🥳 technically it's a bug fix BUT also a significant visual change to the previous version. That's the reason for the version jump from 0.3.0 to 0.4.0

### Bug Fixes

* 🐛 illegal instruction for folder name with whitespace ([9c5b13e](https://github.com/MarcoEidinger/SwiftPlantUML/commit/9c5b13e934c1cf114e7f3080121323600ffae239)), closes [#20](https://github.com/MarcoEidinger/SwiftPlantUML/issues/20)
* 🐛 render Enum with members ([ffb88a6](https://github.com/MarcoEidinger/SwiftPlantUML/commit/ffb88a6c2e64f5af5b4a719e7a5172b9a4aaee80)), closes [#19](https://github.com/MarcoEidinger/SwiftPlantUML/issues/19)
---

## [0.3.0](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.2.1...0.2.2) (2021-02-28)

### Features

* 🎸 show inferred type (if SDK path was provided) ([107f8b6](https://github.com/MarcoEidinger/SwiftPlantUML/commit/107f8b6a6d7597ea9bcff61af2cb6f1136ac8270)), closes [#14](https://github.com/MarcoEidinger/SwiftPlantUML/issues/14)
* 🎸 various configuration options with .swiftplantuml.yml ([6bb08f3](https://github.com/MarcoEidinger/SwiftPlantUML/commit/6bb08f349e9ec0a6cd8a9c8b9386ded2378ac8b7)), closes [#9](https://github.com/MarcoEidinger/SwiftPlantUML/issues/9) and [#10](https://github.com/MarcoEidinger/SwiftPlantUML/issues/10)

### Bug Fixes

* 🐛 multiple file paths handled incorrectly [#12](https://github.com/MarcoEidinger/SwiftPlantUML/issues/12)

## [0.2.1](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.2.0...0.2.1) (2021-02-18)
### Bug Fixes

* 🐛 script error for generic class inheritance ([047d62a](https://github.com/MarcoEidinger/SwiftPlantUML/commit/047d62a21e6641653efaac57d92e55c3992662c5)), closes [#8](https://github.com/MarcoEidinger/SwiftPlantUML/issues/8)

## [0.2.0](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.1.1...0.2.0) (2021-02-04)

### ⚠ BREAKING CHANGES

* 🧨 open PlantUML script + diagram in browser is the new default behavior. Also
CLI flag `--textonly` was dropped in favor of CLI option `--output`

### Features

* 🎸 being able to open PlantUML script + diagram in browser ([1e8ebf7](https://github.com/MarcoEidinger/SwiftPlantUML/commit/1e8ebf72057823ac3bff93088c45052d19495ece))

## [0.1.1](https://github.com/MarcoEidinger/SwiftPlantUML/compare/0.1.0...0.1.1) (2021-01-28)

### Features

* 🎸 generate diagram from a string containing Swift code ([ebdeb59](https://github.com/MarcoEidinger/SwiftPlantUML/commit/ebdeb59c2b788ec75c40e9786fad103416bce6f6))

## 0.1.0 (2020-01-25)

- First public release! 🎉
- CLI tool and Swift Package to generate UML class diagram(s) based on Swift source file(s)
- Use one or more Swift files as input for a diagram to visualize `class`, `struct`, `protocol`, `enum` and `extension` types
with their instance and static members as well as their inheritance and implementation relationships
