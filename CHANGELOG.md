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
