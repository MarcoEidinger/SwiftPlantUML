#if !canImport(ObjectiveC)
    import XCTest

    extension ClassDiagramGeneratorTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__ClassDiagramGeneratorTests = [
            ("testDotAlias", testDotAlias),
            ("testFromString", testFromString),
            ("testNofiles", testNofiles),
            ("testSingleFile", testSingleFile),
            ("testWithConfig", testWithConfig),
        ]
    }

    extension ColorTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__ColorTests = [
            ("testNumberOfColors", testNumberOfColors),
        ]
    }

    extension ConfigurationProviderTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__ConfigurationProviderTests = [
            ("testCustomBad1", testCustomBad1),
            ("testCustomBad2", testCustomBad2),
            ("testCustomGood", testCustomGood),
            ("testDefault", testDefault),
            ("testNonExisting", testNonExisting),
        ]
    }

    extension ElementAccessibilityTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__ElementAccessibilityTests = [
            ("testComparison", testComparison),
        ]
    }

    extension FileCollectorTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__FileCollectorTests = [
            ("testAllFilesStartingFromDirectory", testAllFilesStartingFromDirectory),
            ("testFilesStartingFromDirectoryExcludingDirectory", testFilesStartingFromDirectoryExcludingDirectory),
            ("testFilesStartingFromDirectoryExcludingFileExtension", testFilesStartingFromDirectoryExcludingFileExtension),
            ("testFilesStartingFromDirectoryExcludingFileExtension2", testFilesStartingFromDirectoryExcludingFileExtension2),
            ("testFilesStartingFromDirectoryExcludingFiles", testFilesStartingFromDirectoryExcludingFiles),
            ("testFilesStartingFromDirectoryExcludingFilesInSubdirectory", testFilesStartingFromDirectoryExcludingFilesInSubdirectory),
            ("testFilesStartingFromDirectoryExcludingPrefix", testFilesStartingFromDirectoryExcludingPrefix),
            ("testFilesStartingFromDirectoryExcludingPrefix2", testFilesStartingFromDirectoryExcludingPrefix2),
            ("testFilesStartingFromDirectoryExcludingPrefixInSubdirectory", testFilesStartingFromDirectoryExcludingPrefixInSubdirectory),
            ("testFilesStartingFromDirectoryIncludingAndExcludingFiles", testFilesStartingFromDirectoryIncludingAndExcludingFiles),
            ("testFilesStartingFromDirectoryIncludingFiles", testFilesStartingFromDirectoryIncludingFiles),
        ]
    }

    extension GlobsTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__GlobsTests = [
            ("testDoubleWildcardRegex", testDoubleWildcardRegex),
            ("testDoubleWildcardSlashRegex", testDoubleWildcardSlashRegex),
            ("testEitherOrContainingDotRegex", testEitherOrContainingDotRegex),
            ("testEitherOrRegex", testEitherOrRegex),
            ("testExpandPathWithCharacterClass", testExpandPathWithCharacterClass),
            ("testExpandPathWithDoubleWildcardAtEnd", testExpandPathWithDoubleWildcardAtEnd),
            ("testExpandPathWithSingleCharacterWildcardInMiddle", testExpandPathWithSingleCharacterWildcardInMiddle),
            ("testExpandPathWithSubdirectoryAndWildcard", testExpandPathWithSubdirectoryAndWildcard),
            ("testExpandPathWithWildcardAtEnd", testExpandPathWithWildcardAtEnd),
            ("testExpandPathWithWildcardAtStart", testExpandPathWithWildcardAtStart),
            ("testExpandPathWithWildcardInMiddle", testExpandPathWithWildcardInMiddle),
            ("testExpandWildcardPathWithExactName", testExpandWildcardPathWithExactName),
            ("testGlobCharacterClassDescription", testGlobCharacterClassDescription),
            ("testGlobCharacterRangeDescription", testGlobCharacterRangeDescription),
            ("testGlobDoubleWildcardDescription", testGlobDoubleWildcardDescription),
            ("testGlobDoubleWildcardSlashDescription", testGlobDoubleWildcardSlashDescription),
            ("testGlobEitherOrDescription", testGlobEitherOrDescription),
            ("testGlobEitherOrWithDotsDescription", testGlobEitherOrWithDotsDescription),
            ("testGlobPathDescription", testGlobPathDescription),
            ("testGlobSingleCharacterWildcardDescription", testGlobSingleCharacterWildcardDescription),
            ("testGlobWildcardDescription", testGlobWildcardDescription),
            ("testWildcardRegex", testWildcardRegex),
        ]
    }

    extension LoggerTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__LoggerTests = [
            ("testConsoleLoggerQuit", testConsoleLoggerQuit),
            ("testConsoleLoggerVerbose", testConsoleLoggerVerbose),
            ("testNoLogger", testNoLogger),
            ("testSharedLogger", testSharedLogger),
        ]
    }

    extension PlantUMLBrowserPresenterTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__PlantUMLBrowserPresenterTests = [
            ("testPresenting", testPresenting),
        ]
    }

    extension PlantUMLConfigurationTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__PlantUMLConfigurationTests = [
            ("testDefault", testDefault),
        ]
    }

    extension PlantUMLConsolePresenterTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__PlantUMLConsolePresenterTests = [
            ("testPresenting", testPresenting),
        ]
    }

    extension PlantUMLScriptTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__PlantUMLScriptTests = [
            ("testNoItems", testNoItems),
            ("testScriptWithCustomSkinCommands", testScriptWithCustomSkinCommands),
            ("testScriptWithEmptyHideAndSkinCommands", testScriptWithEmptyHideAndSkinCommands),
            ("testScriptWithInclude", testScriptWithInclude),
            ("testWithRootsSubSyntaxStructure", testWithRootsSubSyntaxStructure),
            ("testWithRootSyntaxStructure", testWithRootSyntaxStructure),
        ]
    }

    extension RelationshipStyleTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__RelationshipStyleTests = [
            ("testPlantUmlRepresentation", testPlantUmlRepresentation),
        ]
    }

    extension StereotypeTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__StereotypeTests = [
            ("testDefaults", testDefaults),
        ]
    }

    extension StringExtensionsTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__StringExtensionsTests = [
            ("testRemoveAngleBracketsWithContent", testRemoveAngleBracketsWithContent),
        ]
    }

    extension SwiftPlantUMLFrameworkTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__SwiftPlantUMLFrameworkTests = [
            ("testStub", testStub),
        ]
    }

    extension SyntaxStructureTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__SyntaxStructureTests = [
            ("testStructureClass", testStructureClass),
            ("testStructureCreate", testStructureCreate),
            ("testStructureElementFind", testStructureElementFind),
            ("testStructureExtension", testStructureExtension),
            ("testStructureExtensionExcluded", testStructureExtensionExcluded),
            ("testStructureProtocol", testStructureProtocol),
            ("testStructurePublicExcluded", testStructurePublicExcluded),
            ("testStructureStruct", testStructureStruct),
        ]
    }

    extension VersionTests {
        // DO NOT MODIFY: This is autogenerated, use:
        //   `swift test --generate-linuxmain`
        // to regenerate.
        static let __allTests__VersionTests = [
            ("testCurrentVersion", testCurrentVersion),
        ]
    }

    public func __allTests() -> [XCTestCaseEntry] {
        [
            testCase(ClassDiagramGeneratorTests.__allTests__ClassDiagramGeneratorTests),
            testCase(ColorTests.__allTests__ColorTests),
            testCase(ConfigurationProviderTests.__allTests__ConfigurationProviderTests),
            testCase(ElementAccessibilityTests.__allTests__ElementAccessibilityTests),
            testCase(FileCollectorTests.__allTests__FileCollectorTests),
            testCase(GlobsTests.__allTests__GlobsTests),
            testCase(LoggerTests.__allTests__LoggerTests),
            testCase(PlantUMLBrowserPresenterTests.__allTests__PlantUMLBrowserPresenterTests),
            testCase(PlantUMLConfigurationTests.__allTests__PlantUMLConfigurationTests),
            testCase(PlantUMLConsolePresenterTests.__allTests__PlantUMLConsolePresenterTests),
            testCase(PlantUMLScriptTests.__allTests__PlantUMLScriptTests),
            testCase(RelationshipStyleTests.__allTests__RelationshipStyleTests),
            testCase(StereotypeTests.__allTests__StereotypeTests),
            testCase(StringExtensionsTests.__allTests__StringExtensionsTests),
            testCase(SwiftPlantUMLFrameworkTests.__allTests__SwiftPlantUMLFrameworkTests),
            testCase(SyntaxStructureTests.__allTests__SyntaxStructureTests),
            testCase(VersionTests.__allTests__VersionTests),
        ]
    }
#endif