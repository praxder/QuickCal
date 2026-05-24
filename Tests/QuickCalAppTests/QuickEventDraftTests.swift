import Foundation
import Testing

@testable import QuickCalApp

struct QuickEventDraftTests {
  @Test func givenNewDraft_whenInitialized_thenEditableFieldsAreEmptyAndDateUsesToday() {
    // Arrange
    let today = Date(timeIntervalSinceReferenceDate: 800_000)

    // Act
    let draft = QuickEventDraft(today: today)

    // Assert
    #expect(draft.naturalLanguageText == "")
    #expect(draft.title == "")
    #expect(draft.location == "")
    #expect(draft.notes == "")
    #expect(draft.date == today)
  }
}
