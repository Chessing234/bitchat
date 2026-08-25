import Testing
@testable import bitchat

struct ComposerAutocorrectPolicyTests {
    @Test func proseLeavesAutocorrectEnabled() {
        #expect(!ComposerAutocorrectPolicy.shouldDisable(for: "hello there", cursor: 11))
        #expect(!ComposerAutocorrectPolicy.shouldDisable(for: "", cursor: 0))
        #expect(!ComposerAutocorrectPolicy.shouldDisable(for: "hello ", cursor: 6))
    }

    @Test func commandMentionAndGeohashTokensDisableAutocorrect() {
        #expect(ComposerAutocorrectPolicy.shouldDisable(for: "/msg", cursor: 4))
        #expect(ComposerAutocorrectPolicy.shouldDisable(for: "hi @al", cursor: 6))
        #expect(ComposerAutocorrectPolicy.shouldDisable(for: "see #u4pr", cursor: 9))
    }

    @Test func completedCommandArgumentIsProseAgain() {
        #expect(!ComposerAutocorrectPolicy.shouldDisable(for: "/msg alice", cursor: 10))
    }

    @Test func currentTokenIsTheRunBeforeTheCursor() {
        #expect(ComposerAutocorrectPolicy.currentToken(in: "hello /j", cursor: 8) == "/j")
        #expect(ComposerAutocorrectPolicy.currentToken(in: "hello ", cursor: 6) == "")
        #expect(ComposerAutocorrectPolicy.currentToken(in: "/msg", cursor: 2) == "/m")
    }
}
