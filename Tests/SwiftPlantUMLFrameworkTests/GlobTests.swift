@testable import SwiftPlantUMLFramework
import XCTest

//
//  GlobsTests.swift
//  SwiftFormatTests
//
//  Created by Nick Lockwood on 31/12/2018.
//  Copyright © 2018 Nick Lockwood. All rights reserved.
//

class GlobsTests: XCTestCase {
    // MARK: glob matching

    func testExpandWildcardPathWithExactName() {
        let path = "Level0.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithWildcardInMiddle() {
        let path = "Level*.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithSingleCharacterWildcardInMiddle() {
        let path = "Level?.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithWildcardAtEnd() {
        let path = "Mock0*"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithDoubleWildcardAtEnd() {
        let path = "Moc**"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithCharacterClass() {
        let path = "Mock0Fi[lL]e.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithWildcardAtStart() {
        let path = "*File.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    func testExpandPathWithSubdirectoryAndWildcard() {
        let path = "Level1/*File.swift"
        let directory = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        XCTAssertEqual(matchGlobs(expandGlobs(path, in: directory), in: directory).count, 1)
    }

    // MARK: glob regex

    func testWildcardRegex() {
        let path = "/Rule*.swift"
        let directory = URL(fileURLWithPath: #file)
        guard case let .regex(regex) = expandGlobs(path, in: directory.path)[0] else {
            return
        }
        XCTAssertEqual(regex.pattern, "^/Rule([^/]+)?\\.swift$")
    }

//
    func testDoubleWildcardRegex() {
        let path = "/**Rule.swift"
        let directory = URL(fileURLWithPath: #file)
        guard case let .regex(regex) = expandGlobs(path, in: directory.path)[0] else {
            return
        }
        XCTAssertEqual(regex.pattern, "^/.+Rule\\.swift$")
    }

    func testDoubleWildcardSlashRegex() {
        let path = "/**/Rule.swift"
        let directory = URL(fileURLWithPath: #file)
        guard case let .regex(regex) = expandGlobs(path, in: directory.path)[0] else {
            return
        }
        XCTAssertEqual(regex.pattern, "^/(.+/)?Rule\\.swift$")
    }

    func testEitherOrRegex() {
        let path = "/SwiftFormat.{h,swift}"
        let directory = URL(fileURLWithPath: #file)
        guard case let .regex(regex) = expandGlobs(path, in: directory.path)[0] else {
            return
        }
        XCTAssertEqual(regex.pattern, "^/SwiftFormat\\.(h|swift)$")
    }

    func testEitherOrContainingDotRegex() {
        let path = "/SwiftFormat{.h,.swift}"
        let directory = URL(fileURLWithPath: #file)
        guard case let .regex(regex) = expandGlobs(path, in: directory.path)[0] else {
            return
        }
        XCTAssertEqual(regex.pattern, "^/SwiftFormat(\\.h|\\.swift)$")
    }

    // MARK: glob description

    func testGlobPathDescription() {
        let path = "/foo/bar.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobWildcardDescription() {
        let path = "/foo/*.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobDoubleWildcardDescription() {
        let path = "/foo/**bar.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobDoubleWildcardSlashDescription() {
        let path = "/foo/**/bar.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobSingleCharacterWildcardDescription() {
        let path = "/foo/ba?.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobEitherOrDescription() {
        let path = "/foo/{bar,baz}.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobEitherOrWithDotsDescription() {
        let path = "/foo{.swift,.txt}"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobCharacterClassDescription() {
        let path = "/Options[DS]*.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }

    func testGlobCharacterRangeDescription() {
        let path = "/Options[D-S]*.swift"
        let directory = URL(fileURLWithPath: #file)
        let globs = expandGlobs(path, in: directory.path)
        XCTAssertEqual(globs[0].description, path)
    }
}
