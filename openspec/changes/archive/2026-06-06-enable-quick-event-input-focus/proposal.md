## Why

The quick event entry panel renders correctly but every keyboard-driven control is unusable: the event title field, natural-language entry, notes editor, and date/time pickers cannot be focused or edited. The panel's window is configured with `styleMask: [.fullSizeContentView]` and no `.titled`/`.resizable`, so `NSWindow.canBecomeKey` is `false`. A window that cannot become key cannot host a first responder, so no control can receive keyboard focus. The spec already promises these controls are "editable," but they are not.

## What Changes

- Make the quick event entry window able to become key so its controls can receive keyboard focus and text input, while keeping the panel visually borderless.
  - Add `.titled` to the window `styleMask`; the existing transparent titlebar, hidden title, and hidden standard window buttons keep the panel looking chrome-free.
- Reframe the existing `PanelOnlyWindowConfiguration` test that asserts the style mask does NOT contain `.titled`. That assertion encodes the bug. The intent is "no visible titlebar chrome," achieved via transparency + hidden buttons, not by dropping `.titled`.
- Switch the date and time `DatePicker`s in `TimeControls` from `.compact` style to the classic textfield-and-stepper style (`.field` / `.stepperField`) so a user can click a component and type digits to enter a date/time directly.

## Capabilities

### New Capabilities
<!-- none -->

### Modified Capabilities
- `quick-event-entry-ui`: Strengthen the "visible detail controls" behavior — controls must accept keyboard focus and direct text/numeric input, and date/time controls must support direct component-level typing — and clarify that the panel stays visually borderless while remaining key-capable.

## Impact

- `Sources/QuickCalApp/PanelOnlyWindowConfiguration.swift` — `styleMask` gains `.titled`.
- `Sources/QuickCalApp/QuickEventEntryView.swift` — `TimeControls` date/time picker style.
- `Tests/QuickCalAppTests/QuickEventEntryViewTests.swift` — reframe the titlebar-chrome assertion.
- No new dependencies. No change to launch/activation behavior. No macOS Calendar side effects.
