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

  func test_givenDateAndTimes_whenEventInterval_thenDayComesFromDateAndTimeFromPickers() {
    // Arrange
    let calendar = Calendar(identifier: .gregorian)
    var draft = QuickEventDraft()
    draft.date = makeDate(year: 2026, month: 6, day: 7, hour: 9, minute: 0, calendar: calendar)
    draft.startTime = makeDate(
      year: 2000, month: 1, day: 1, hour: 14, minute: 30, calendar: calendar)
    draft.endTime = makeDate(year: 2000, month: 1, day: 1, hour: 15, minute: 45, calendar: calendar)

    // Act
    let interval = draft.eventInterval(calendar: calendar)

    // Assert
    XCTAssertEqual(
      interval.start,
      makeDate(year: 2026, month: 6, day: 7, hour: 14, minute: 30, calendar: calendar))
    XCTAssertEqual(
      interval.end, makeDate(year: 2026, month: 6, day: 7, hour: 15, minute: 45, calendar: calendar)
    )
  }

  func test_givenEndTimeNotAfterStartTime_whenEventInterval_thenEndRollsToNextDay() {
    // Arrange
    let calendar = Calendar(identifier: .gregorian)
    var draft = QuickEventDraft()
    draft.date = makeDate(year: 2026, month: 6, day: 7, calendar: calendar)
    draft.startTime = makeDate(
      year: 2000, month: 1, day: 1, hour: 23, minute: 0, calendar: calendar)
    draft.endTime = makeDate(year: 2000, month: 1, day: 1, hour: 1, minute: 0, calendar: calendar)

    // Act
    let interval = draft.eventInterval(calendar: calendar)

    // Assert
    XCTAssertEqual(
      interval.start,
      makeDate(year: 2026, month: 6, day: 7, hour: 23, minute: 0, calendar: calendar))
    XCTAssertEqual(
      interval.end, makeDate(year: 2026, month: 6, day: 8, hour: 1, minute: 0, calendar: calendar))
  }
}

private func makeDate(
  year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, calendar: Calendar
) -> Date {
  var components = DateComponents()
  components.year = year
  components.month = month
  components.day = day
  components.hour = hour
  components.minute = minute
  return calendar.date(from: components)!
}
