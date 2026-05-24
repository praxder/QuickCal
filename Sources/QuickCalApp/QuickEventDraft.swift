import Foundation

struct QuickEventDraft {
  var naturalLanguageText: String
  var title: String
  var location: String
  var notes: String
  var date: Date
  var startTime: Date
  var endTime: Date
  var isAllDay: Bool
  var calendar: String
  var repeatOption: String
  var reminder: String

  init(today: Date = Date()) {
    naturalLanguageText = ""
    title = ""
    location = ""
    notes = ""
    date = today
    startTime = today
    endTime = Calendar.current.date(byAdding: .hour, value: 1, to: today) ?? today
    isAllDay = false
    calendar = "Personal"
    repeatOption = "Does not repeat"
    reminder = "No reminder"
  }
}
