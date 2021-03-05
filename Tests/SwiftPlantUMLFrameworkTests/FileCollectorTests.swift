@testable import SwiftPlantUMLFramework
import XCTest

final class FileCollectorTests: XCTestCase {
    func testAllFilesStartingFromDirectory() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir)
        XCTAssertEqual(files.count, 8)
    }

    func testFilesStartingFromDirectoryExcludingPrefix() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["**/Mock*.swift"]))
        XCTAssertEqual(files.count, 4)
    }

    func testFilesStartingFromDirectoryExcludingFileExtension() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["*.swift"]))
        XCTAssertEqual(files.count, 6)
    }

    func testFilesStartingFromDirectoryExcludingFileExtension2() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["**/*.swift"]))
        XCTAssertEqual(files.count, 0)
    }

    func testFilesStartingFromDirectoryExcludingPrefix2() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["**/Mock*.swift"]))
        XCTAssertEqual(files.count, 4)
    }

    func testFilesStartingFromDirectoryExcludingPrefixInSubdirectory() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["Level 1/Level2/Mock*.swift"]))
        XCTAssertEqual(files.count, 7)
    }

    func testFilesStartingFromDirectoryExcludingFilesInSubdirectory() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["Level 1/Level1.swift"]))
        XCTAssertEqual(files.count, 7)
    }

    func testFilesStartingFromDirectoryExcludingFiles() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["Level 0.swift"]))
        XCTAssertEqual(files.count, 7)
    }

    func testFilesStartingFromDirectoryExcludingDirectory() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: nil, exclude: ["**/Level2/**"]))
        XCTAssertEqual(files.count, 4)
    }

    func testFilesStartingFromDirectoryIncludingFiles() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: ["Level 0.swift"], exclude: nil))
        XCTAssertEqual(files.count, 1)
    }

    func testFilesStartingFromDirectoryIncludingAndExcludingFiles() {
        let testDir = TestResources.path.stringByAppendingPathComponent("ProjectMock")
        let files = FileCollector().getFiles(for: ["."], in: testDir, honoring: FileOptions(include: ["Level 0.swift"], exclude: ["Level 0.swift"]))
        XCTAssertEqual(files.count, 0)
    }
}
