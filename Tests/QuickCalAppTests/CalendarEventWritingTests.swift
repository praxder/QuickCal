import Foundation
import XCTest

@testable import QuickCalApp

final class CalendarEventWritingTests: XCTestCase {
  func test_givenDraftWithTitle_whenCreateCalendarEvent_thenWriterSavesMappedTitleAndInterval()
    async throws
  {
    // Arrange
    let writer = FakeCalendarWriter()
    var draft = QuickEventDraft()
    draft.title = "Lunch"
    let expected = draft.eventInterval()

    // Act
    try await createCalendarEvent(from: draft, using: writer)

    // Assert
    XCTAssertEqual(writer.savedCalls.count, 1)
    XCTAssertEqual(writer.savedCalls.first?.title, "Lunch")
    XCTAssertEqual(writer.savedCalls.first?.start, expected.start)
    XCTAssertEqual(writer.savedCalls.first?.end, expected.end)
  }

  func test_givenDraftWithBlankTitle_whenCreateCalendarEvent_thenThrowsMissingTitleAndNeverSaves()
    async
  {
    // Arrange
    let writer = FakeCalendarWriter()
    var draft = QuickEventDraft()
    draft.title = "   "

    // Act / Assert
    do {
      try await createCalendarEvent(from: draft, using: writer)
      XCTFail("Expected createCalendarEvent to throw")
    } catch let error as CalendarEventError {
      XCTAssertEqual(error, .missingTitle)
    } catch {
      XCTFail("Expected CalendarEventError, got \(error)")
    }
    XCTAssertTrue(writer.savedCalls.isEmpty)
  }
}

private final class FakeCalendarWriter: CalendarEventWriting {
  private(set) var savedCalls: [(title: String, start: Date, end: Date)] = []

  func save(title: String, start: Date, end: Date) async throws {
    savedCalls.append((title, start, end))
  }
}
