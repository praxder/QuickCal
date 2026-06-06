## 1. Make the panel window key-capable

- [x] 1.1 Reframe `test_givenPanelOnlyWindowConfiguration_whenInspected_thenItRemovesTitlebarChrome` in `Tests/QuickCalAppTests/QuickEventEntryViewTests.swift`: assert `styleMask` CONTAINS `.titled`, and that chrome is hidden via `titleVisibility == .hidden` and `titlebarAppearsTransparent == true` (run: expect red).
- [x] 1.2 Add `.titled` to `styleMask` in `PanelOnlyWindowConfiguration.quickEventEntry` (`Sources/QuickCalApp/PanelOnlyWindowConfiguration.swift`) → `[.titled, .fullSizeContentView]` (run: expect green).

## 2. Enable direct date/time entry

- [x] 2.1 Switch the three `DatePicker`s in `TimeControls` (`Sources/QuickCalApp/QuickEventEntryView.swift`) from `.datePickerStyle(.compact)` to `.datePickerStyle(.field)`.

## 3. Verify

- [x] 3.1 Run `swift build` and `swift test` — all tests pass.
- [x] 3.2 Run the app; click the event title field — it focuses and accepts typing.
- [x] 3.3 Click a date/time component — it accepts typed digits to set the value directly.
- [x] 3.4 Confirm the unblocked editors also work: natural-language entry and notes accept focus and typing.
- [x] 3.5 Visually confirm the panel still reads as a clean borderless panel (no titlebar seam, no standard window buttons, rounded corners intact); if a seam appears, adjust corner radius/background per design.md.
