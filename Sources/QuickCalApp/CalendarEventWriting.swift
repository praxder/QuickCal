import EventKit
import Foundation

protocol CalendarEventWriting {
  func save(title: String, start: Date, end: Date) async throws
}

enum CalendarEventError: LocalizedError, Equatable {
  case missingTitle
  case accessDenied

  var errorDescription: String? {
    switch self {
    case .missingTitle:
      return "Enter an event title before creating the event."
    case .accessDenied:
      return
        "Calendar access was denied. Enable it in System Settings › Privacy & Security › Calendars."
    }
  }
}

func createCalendarEvent(from draft: QuickEventDraft, using writer: CalendarEventWriting)
  async throws
{
  let title = draft.title.trimmingCharacters(in: .whitespacesAndNewlines)
  guard !title.isEmpty else {
    throw CalendarEventError.missingTitle
  }
  let interval = draft.eventInterval()
  try await writer.save(title: title, start: interval.start, end: interval.end)
}

struct EventKitCalendarWriter: CalendarEventWriting {
  private let store: EKEventStore

  init(store: EKEventStore = EKEventStore()) {
    self.store = store
  }

  func save(title: String, start: Date, end: Date) async throws {
    let granted = try await store.requestWriteOnlyAccessToEvents()
    guard granted else {
      throw CalendarEventError.accessDenied
    }
    let event = EKEvent(eventStore: store)
    event.title = title
    event.startDate = start
    event.endDate = end
    event.calendar = store.defaultCalendarForNewEvents
    try store.save(event, span: .thisEvent)
  }
}
