## Why

QuickCal needs an initial macOS surface that matches the provided Stitch "Quick Event Main Page - Dark" design before deeper behavior is added. Starting with a close native SwiftUI copy gives the project a concrete UI target for later parsing, shortcut, and Calendar integration work.

## What Changes

- Add a native SwiftUI macOS panel view that closely matches `/Users/adam/Downloads/stitch_natural_event_entry/screen.png`.
- Use empty input fields by default, with the date control initialized to today's date.
- Recreate the dark floating panel structure: natural-language entry area, details section, editable rows, calendar/repeat/reminder controls, notes area, settings button, cancel button, and create event button.
- Defer natural-language parsing, global keyboard shortcut handling, and writing events to the macOS Calendar app.

## Capabilities

### New Capabilities
- `quick-event-entry-ui`: Covers the visible native SwiftUI main page for entering quick event details.

### Modified Capabilities

None.

## Impact

- Affects the future macOS app target and SwiftUI view structure.
- Adds no Calendar permissions, EventKit behavior, parsing service, persistence, or global shortcut behavior in this change.
