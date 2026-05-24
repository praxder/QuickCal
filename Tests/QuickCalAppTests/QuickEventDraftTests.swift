import Foundation
import XCTest

@testable import QuickCalApp

final class QuickEventDraftTests: XCTestCase {
  func test_givenNewDraft_whenInitialized_thenEditableFieldsAreEmptyAndDateUsesToday() {
    // Arrange
    let today = Date(timeIntervalSinceReferenceDate: 800_000)

    // Act
    let draft = QuickEventDraft(today: today)

    // Assert
    XCTAssertEqual(draft.naturalLanguageText, "")
    XCTAssertEqual(draft.title, "")
    XCTAssertEqual(draft.location, "")
    XCTAssertEqual(draft.notes, "")
    XCTAssertEqual(draft.date, today)
  }
}
