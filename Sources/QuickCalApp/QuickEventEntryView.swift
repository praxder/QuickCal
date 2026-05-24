import SwiftUI

struct QuickEventEntryView: View {
  @State private var draft: QuickEventDraft

  init(draft: QuickEventDraft = QuickEventDraft()) {
    _draft = State(initialValue: draft)
  }

  var body: some View {
    ZStack {
      VisualBackdrop()

      VStack(spacing: 0) {
        NaturalLanguageEntry(text: $draft.naturalLanguageText)
        DetailsSection(draft: $draft)
        PanelFooter()
      }
      .frame(width: 460)
      .background(Color.panel)
      .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
      .overlay {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .stroke(Color.outline, lineWidth: 1)
      }
      .shadow(color: .black.opacity(0.36), radius: 24, y: 12)
    }
    .frame(width: 700, height: 640)
    .preferredColorScheme(.dark)
  }
}

private struct VisualBackdrop: View {
  var body: some View {
    LinearGradient(
      colors: [.purple.opacity(0.42), .orange.opacity(0.45), .teal.opacity(0.38)],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    .overlay(.black.opacity(0.48))
    .blur(radius: 18)
    .ignoresSafeArea()
  }
}

private struct NaturalLanguageEntry: View {
  @Binding var text: String

  var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $text)
        .font(.system(size: 17, weight: .semibold))
        .foregroundStyle(.white)
        .scrollContentBackground(.hidden)
        .frame(minHeight: 112)

      if text.isEmpty {
        Text("Dinner with Mom at 7pm on Friday...")
          .font(.system(size: 17, weight: .semibold))
          .foregroundStyle(Color.secondaryText)
          .padding(.top, 8)
          .padding(.leading, 5)
          .allowsHitTesting(false)
      }
    }
    .padding(16)
    .background(Color.panel)
    .overlay(alignment: .bottom) {
      Divider().background(Color.outline)
    }
  }
}

private struct DetailsSection: View {
  @Binding var draft: QuickEventDraft

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("DETAILS")
        .font(.system(size: 10, weight: .semibold))
        .foregroundStyle(.white)

      IconRow(systemName: "text.alignleft") {
        DarkTextField("Event title", text: $draft.title)
      }

      IconRow(systemName: "clock") {
        TimeControls(draft: $draft)
      }

      IconRow(systemName: "location") {
        DarkTextField("Add location...", text: $draft.location)
      }

      IconRow(systemName: "calendar") {
        PickerRow(selection: $draft.calendar, options: ["Personal", "Work", "Family"])
        Circle().fill(Color.accentBlue).frame(width: 10, height: 10)
      }

      IconRow(systemName: "repeat") {
        PickerRow(
          selection: $draft.repeatOption,
          options: ["Does not repeat", "Daily", "Weekly", "Monthly", "Yearly"])
      }

      IconRow(systemName: "bell") {
        PickerRow(
          selection: $draft.reminder,
          options: [
            "No reminder", "At time of event", "5 minutes before", "15 minutes before",
            "1 hour before",
          ])
      }

      IconRow(systemName: "doc.text", alignment: .top) {
        NotesEditor(notes: $draft.notes)
      }
    }
    .padding(16)
    .background(Color.section)
  }
}

private struct IconRow<Content: View>: View {
  let systemName: String
  var alignment: VerticalAlignment = .center
  @ViewBuilder var content: Content

  var body: some View {
    HStack(alignment: alignment, spacing: 12) {
      Image(systemName: systemName)
        .font(.system(size: 15, weight: .medium))
        .foregroundStyle(Color.icon)
        .frame(width: 20)

      HStack(spacing: 8) {
        content
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
  }
}

private struct TimeControls: View {
  @Binding var draft: QuickEventDraft

  var body: some View {
    HStack(spacing: 10) {
      HStack(spacing: 8) {
        DatePicker("", selection: $draft.date, displayedComponents: .date)
          .labelsHidden()
          .datePickerStyle(.compact)

        DatePicker("", selection: $draft.startTime, displayedComponents: .hourAndMinute)
          .labelsHidden()
          .datePickerStyle(.compact)

        Image(systemName: "arrow.right")
          .foregroundStyle(Color.secondaryText)

        DatePicker("", selection: $draft.endTime, displayedComponents: .hourAndMinute)
          .labelsHidden()
          .datePickerStyle(.compact)
      }
      .controlSize(.small)
      .padding(4)
      .background(FieldBackground())

      Spacer(minLength: 6)

      Text("All Day")
        .font(.system(size: 12))
        .foregroundStyle(.white)

      Toggle("", isOn: $draft.isAllDay)
        .labelsHidden()
        .toggleStyle(.switch)
        .controlSize(.mini)
    }
  }
}

private struct DarkTextField: View {
  let prompt: String
  @Binding var text: String

  init(_ prompt: String, text: Binding<String>) {
    self.prompt = prompt
    _text = text
  }

  var body: some View {
    TextField(prompt, text: $text)
      .textFieldStyle(.plain)
      .font(.system(size: 13))
      .foregroundStyle(.white)
      .padding(.horizontal, 10)
      .padding(.vertical, 7)
      .background(FieldBackground())
  }
}

private struct PickerRow: View {
  @Binding var selection: String
  let options: [String]

  var body: some View {
    Picker("", selection: $selection) {
      ForEach(options, id: \.self) { option in
        Text(option).tag(option)
      }
    }
    .labelsHidden()
    .pickerStyle(.menu)
    .controlSize(.small)
    .frame(width: 200, alignment: .leading)
    .background(FieldBackground())
  }
}

private struct NotesEditor: View {
  @Binding var notes: String

  var body: some View {
    ZStack(alignment: .topLeading) {
      TextEditor(text: $notes)
        .font(.system(size: 13))
        .foregroundStyle(.white)
        .scrollContentBackground(.hidden)
        .frame(minHeight: 78)

      if notes.isEmpty {
        Text("Add notes...")
          .font(.system(size: 13))
          .foregroundStyle(Color.secondaryText)
          .padding(.top, 8)
          .padding(.leading, 5)
          .allowsHitTesting(false)
      }
    }
    .padding(.horizontal, 6)
    .background(FieldBackground())
  }
}

private struct PanelFooter: View {
  var body: some View {
    HStack {
      Button {
      } label: {
        Image(systemName: "gearshape")
          .font(.system(size: 18, weight: .medium))
      }
      .buttonStyle(IconButtonStyle())
      .accessibilityLabel("Settings")

      Spacer()

      Button("Cancel") {
      }
      .buttonStyle(SecondaryButtonStyle())

      Button("Create Event") {
      }
      .buttonStyle(PrimaryButtonStyle())
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 12)
    .background(Color.footer)
    .overlay(alignment: .top) {
      Divider().background(Color.outline)
    }
  }
}

private struct FieldBackground: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 6, style: .continuous)
      .fill(Color.field)
      .overlay {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
          .stroke(Color.outline, lineWidth: 1)
      }
  }
}

private struct IconButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundStyle(Color.icon)
      .padding(6)
      .background(configuration.isPressed ? Color.field : .clear)
      .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
  }
}

private struct SecondaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 13))
      .foregroundStyle(.white)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(configuration.isPressed ? Color.field : .clear)
      .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
  }
}

private struct PrimaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 13, weight: .medium))
      .foregroundStyle(.white)
      .padding(.horizontal, 12)
      .padding(.vertical, 6)
      .background(configuration.isPressed ? Color.blue.opacity(0.82) : Color.primaryBlue)
      .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
  }
}

extension Color {
  fileprivate static let accentBlue = Color(red: 0.67, green: 0.78, blue: 1.0)
  fileprivate static let field = Color(red: 0.13, green: 0.13, blue: 0.14)
  fileprivate static let footer = Color.black.opacity(0.38)
  fileprivate static let icon = Color(red: 0.75, green: 0.77, blue: 0.84)
  fileprivate static let outline = Color.white.opacity(0.12)
  fileprivate static let panel = Color(red: 0.11, green: 0.11, blue: 0.12)
  fileprivate static let primaryBlue = Color(red: 0.04, green: 0.45, blue: 0.94)
  fileprivate static let secondaryText = Color(red: 0.52, green: 0.54, blue: 0.61)
  fileprivate static let section = Color.black.opacity(0.22)
}
