import Foundation
/// Descriptive texts ("common commands") you can add around your diagram
public struct PageTexts: Codable {
    internal init(header: String? = nil, title: String? = nil, legend: String? = nil, caption: String? = nil, footer: String? = nil) {
        self.header = header
        self.title = title
        self.legend = legend
        self.caption = caption
        self.footer = footer
    }

    /// add a header to the top right above the diagram
    public var header: String?
    /// add a title above the diagram
    public var title: String?
    /// add a legend (boxed text) under the diagram but above the caption
    public var legend: String?
    /// add a caption under the diagram
    public var caption: String?
    /// add a footer at the bottom below the diagram
    public var footer: String?
}

extension PageTexts {
    func plantuml() -> String? {
        if header == nil,
           title == nil,
           legend == nil,
           caption == nil,
           footer == nil
        {
            return nil
        }
        var text = ""
        if let header = header {
            text.appendAsNewLine("header")
            text.appendAsNewLine(header)
            text.appendAsNewLine("end header")
        }
        if let title = title {
            text.appendAsNewLine("title")
            text.appendAsNewLine(title)
            text.appendAsNewLine("end title")
        }
        if let legend = legend {
            text.appendAsNewLine("legend")
            text.appendAsNewLine(legend)
            text.appendAsNewLine("end legend")
        }
        if let caption = caption {
            text.appendAsNewLine("caption")
            text.appendAsNewLine(caption)
            text.appendAsNewLine("end caption")
        }
        if let footer = footer {
            text.appendAsNewLine("footer")
            text.appendAsNewLine(footer)
            text.appendAsNewLine("end footer")
        }
        return text
    }
}
