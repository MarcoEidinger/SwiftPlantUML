@testable import SwiftPlantUMLFramework
import XCTest

final class PageTextsTests: XCTestCase {
    func testNone() throws {
        let texts = PageTexts()
        XCTAssertNil(texts.plantuml())
    }

    func testHeader() throws {
        let headerText = """
        <u>Simple</u> header example
        on <i>several</i> lines and using <font color=red>html</font>
        """

        let texts = PageTexts(header: headerText)
        let result = texts.plantuml()

        let expected = """

        header
        \(headerText)
        end header
        """
        XCTAssertEqual(result, expected)
    }

    func testTitle() throws {
        let titleText = """
        <u>Simple</u> title example
        on <i>several</i> lines and using <font color=red>html</font>
        """

        let texts = PageTexts(title: titleText)
        let result = texts.plantuml()

        let expected = """

        title
        \(titleText)
        end title
        """
        XCTAssertEqual(result, expected)
    }

    func testLegend() throws {
        let legendText = """
        <u>Simple</u> legend example
        on <i>several</i> lines and using <font color=red>html</font>
        """

        let texts = PageTexts(legend: legendText)
        let result = texts.plantuml()

        let expected = """

        legend
        \(legendText)
        end legend
        """
        XCTAssertEqual(result, expected)
    }

    func testCaption() throws {
        let captionText = """
        <u>Simple</u> caption example
        on <i>several</i> lines and using <font color=red>html</font>
        """

        let texts = PageTexts(caption: captionText)
        let result = texts.plantuml()

        let expected = """

        caption
        \(captionText)
        end caption
        """
        XCTAssertEqual(result, expected)
    }

    func testFooter() throws {
        let footerText = """
        <u>Simple</u> footer example
        on <i>several</i> lines and using <font color=red>html</font>
        """

        let texts = PageTexts(footer: footerText)
        let result = texts.plantuml()

        let expected = """

        footer
        \(footerText)
        end footer
        """
        XCTAssertEqual(result, expected)
    }

    func testAll() throws {
        let texts = PageTexts(header: "1", title: "2", legend: "3", caption: "4", footer: "5")
        let result = try XCTUnwrap(texts.plantuml())
        XCTAssertTrue(result.contains("1"))
        XCTAssertTrue(result.contains("2"))
        XCTAssertTrue(result.contains("3"))
        XCTAssertTrue(result.contains("4"))
        XCTAssertTrue(result.contains("5"))
    }
}
