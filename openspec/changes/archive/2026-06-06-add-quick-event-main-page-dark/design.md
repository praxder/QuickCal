## Context

QuickCal is a new macOS utility app with no app scaffold yet. The first UI target is the Google Stitch dark mockup in `/Users/adam/Downloads/stitch_natural_event_entry/`, especially `screen.png` and its accompanying `DESIGN.md`/`code.html`.

The page is a compact floating dark panel for fast calendar entry. The first pass should copy the native-feeling shape closely in SwiftUI while staying intentionally narrow: no parsing, no global shortcut, and no Calendar write behavior.

## Goals / Non-Goals

**Goals:**
- Create a native SwiftUI macOS page matching the Stitch dark mockup as closely as practical.
- Preserve the panel structure: large natural-language entry area, details rows, notes area, and footer actions.
- Initialize visible editable fields empty, except the date control which uses today's date.
- Use macOS-native building blocks where they can be styled to match the mockup.

**Non-Goals:**
- Natural-language event parsing.
- EventKit or Calendar permission handling.
- Creating, editing, or deleting real Calendar events.
- Global keyboard shortcut registration.
- Settings behavior beyond rendering the settings control.
- Light mode.

## Decisions

### Native SwiftUI Instead Of WebView

The main page will be implemented as SwiftUI views rather than embedding the Stitch HTML.

Rationale: QuickCal is a macOS utility app. Native SwiftUI keeps future app-window behavior, keyboard handling, focus, accessibility, and Calendar integration straightforward. The Stitch HTML remains a visual reference, not a runtime dependency.

Alternative considered: render the provided `code.html` in a WebView. That would be faster for visual parity but would make later native Calendar integration and keyboard behavior more awkward.

### Panel View With Local Presentation State

The first page will use local SwiftUI state for visible fields: natural-language input, title, start date, start time, end time, all-day toggle, location, calendar, repeat, reminder, and notes.

Rationale: Empty editable fields let the page feel like the target utility without pretending parsing exists. Local state is enough for visual and interaction validation.

Alternative considered: static text-only mockup. That would be cheaper but less useful for judging native control sizing, focus rings, and keyboard entry.

### Custom Styling Around Native Controls

Use `TextEditor`, `TextField`, `DatePicker`, `Toggle`, `Picker`, and `Button` where practical, with custom dark backgrounds, borders, compact spacing, and SF Symbols to match the mockup.

Rationale: The mockup uses web-style controls, but the finished product should feel like a Mac app. Styling native controls gives a close copy while preserving platform behavior.

Alternative considered: draw all controls from custom shapes and text. That can improve screenshot similarity but loses expected macOS interactions.

### Deferred App Shell Details

If an app scaffold is created as part of implementation, it should expose this page as the initial window content. Floating behavior, global shortcut trigger, and final window chrome can be refined after the page exists.

Rationale: The current change is about the main page. Keeping shell behavior minimal avoids mixing visual copy work with shortcut and Calendar concerns.

## Risks / Trade-offs

- SwiftUI native controls will not exactly match Tailwind HTML controls by default -> Mitigate with small custom wrappers for field rows and compact control styling.
- macOS version differences can affect picker/date/toggle rendering -> Keep critical visual elements such as borders, spacing, icons, and panel surfaces under app control.
- A visual-only page could accidentally imply Calendar behavior exists -> Keep footer actions inert or limited to local UI behavior in this change.
- Overfitting to one screenshot could make later resizing harder -> Use fixed target dimensions for the initial panel and simple layout constraints rather than building a broad responsive system now.
