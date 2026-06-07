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

  func eventInterval(calendar: Calendar = .current) -> (start: Date, end: Date) {
    let start = combine(day: date, time: startTime, calendar: calendar)
    var end = combine(day: date, time: endTime, calendar: calendar)
    if end <= start {
      end = calendar.date(byAdding: .day, value: 1, to: end) ?? end
    }
    return (start, end)
  }
}

private func combine(day: Date, time: Date, calendar: Calendar) -> Date {
  let dayParts = calendar.dateComponents([.year, .month, .day], from: day)
  let timeParts = calendar.dateComponents([.hour, .minute, .second], from: time)
  var merged = DateComponents()
  merged.year = dayParts.year
  merged.month = dayParts.month
  merged.day = dayParts.day
  merged.hour = timeParts.hour
  merged.minute = timeParts.minute
  merged.second = timeParts.second
  return calendar.date(from: merged) ?? day
}
