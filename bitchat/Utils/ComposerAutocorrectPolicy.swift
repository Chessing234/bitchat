import Foundation

/// When the composer should suppress system autocorrect.
///
/// `/commands`, `@mentions`, and `#geohash` tokens need the exact typed text
/// for autocomplete. Prose should still get autocorrect. The token under the
/// cursor is the substring after the last whitespace before `cursor`.
enum ComposerAutocorrectPolicy {
    static func shouldDisable(for text: String, cursor: Int) -> Bool {
        guard let first = currentToken(in: text, cursor: cursor).first else { return false }
        return first == "/" || first == "@" || first == "#"
    }

    static func currentToken(in text: String, cursor: Int) -> String {
        guard !text.isEmpty else { return "" }
        let clamped = max(0, min(cursor, text.count))
        let idx = text.index(text.startIndex, offsetBy: clamped)
        let before = text[..<idx]
        if let lastWhitespace = before.lastIndex(where: { $0.isWhitespace }) {
            return String(before[before.index(after: lastWhitespace)...])
        }
        return String(before)
    }
}
