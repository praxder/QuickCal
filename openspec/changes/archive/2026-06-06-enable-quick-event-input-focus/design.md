## Context

The quick event entry panel is a SwiftUI `WindowGroup` whose window is reconfigured at runtime by `PanelOnlyWindowConfigurator` (an `NSViewRepresentable` placed in the view's `.background`). To get the floating-panel look, `PanelOnlyWindowConfiguration.quickEventEntry` sets `styleMask = [.fullSizeContentView]`, hides the title, makes the titlebar transparent, and hides the standard window buttons.

The side effect: `NSWindow.canBecomeKey` returns `true` only when the window has a title bar or a resize bar. With neither `.titled` nor `.resizable` in the mask, the window can never become key. A non-key window cannot host a first responder, so the title field, natural-language editor, notes editor, and the date/time pickers are all inert — clicks and typing do nothing. The visible `.activate()` call makes the window *main* (frontmost) but not *key*.

Deployment target is macOS 14.

## Goals / Non-Goals

**Goals:**
- The panel's controls accept keyboard focus and text input.
- Date and time can be entered by clicking a component and typing digits directly.
- The panel keeps its borderless, chrome-free appearance.

**Non-Goals:**
- No change to launch/activation policy or window placement.
- No macOS Calendar writes (still inert).
- No redesign of the panel layout, colors, or other controls.

## Decisions

### Decision: Add `.titled` to the style mask instead of subclassing `NSWindow`
`canBecomeKey` is a method on `NSWindow`. The only ways to flip it to `true` are (a) give the window a title bar or resize bar via the style mask, or (b) subclass `NSWindow` and override `canBecomeKey`/`canBecomeMain`.

We do not construct the window — SwiftUI's `WindowGroup` does — so swapping its class is not clean. The pragmatic, standard recipe is to include `.titled` and neutralize its chrome: `titlebarAppearsTransparent = true`, `titleVisibility = .hidden`, `.fullSizeContentView`, and hidden standard buttons (all already present). Result: a window that looks borderless but can become key.

`styleMask: [.fullSizeContentView]` → `styleMask: [.titled, .fullSizeContentView]`.

*Alternative considered:* subclassing `NSWindow` to override `canBecomeKey`. Rejected — requires owning window creation, which `WindowGroup` does not expose cleanly; more code for no visual benefit.

### Decision: Use `.field` (textfield) style for the date/time pickers
Switch the three `DatePicker`s in `TimeControls` from `.datePickerStyle(.compact)` to `.datePickerStyle(.field)`. The `.field` style renders the classic `NSDatePicker` editable text control: click a component (month, day, hour…) and type digits to set it directly, satisfying "manually edit and directly input." `.compact` is popover-first and does not guarantee inline typing.

*Alternative considered:* `.stepperField` (textfield + up/down stepper). Equivalent typing behavior but adds stepper arrows that clutter the small dark pill. Keep as a fallback if `.field` renders poorly inside `FieldBackground`.

### Decision: Reframe the titlebar-chrome test, do not delete it
`test_givenPanelOnlyWindowConfiguration_whenInspected_thenItRemovesTitlebarChrome` currently asserts `XCTAssertFalse(styleMask.contains(.titled))`. That assertion encodes the bug. The requirement it protects is "no *visible* titlebar chrome," which is enforced by `titleVisibility == .hidden`, `titlebarAppearsTransparent == true`, and hidden standard buttons — not by removing `.titled`. Update the assertions to check those properties (and assert `.titled` IS present), keeping the test's intent intact.

## Risks / Trade-offs

- **`.titled` reintroduces system window rounded corners / chrome that fights the SwiftUI `clipShape` corner radius** → Confirmed during verification: SwiftUI inset the panel below the titlebar safe area, exposing a dark titlebar strip above the rounded panel. Resolved by adding `.ignoresSafeArea()` to the panel root so the rounded content fills the full window under the transparent titlebar, plus a `titlebarInset` (28pt) top padding on the natural-language area so its text/clicks clear the titlebar drag region. `.titled` retained, so focus stays working.
- **`isMovableByWindowBackground` behavior with a (transparent) titlebar present** → Dragging by the background should still work; confirm during verification.
- **`.field` picker visual fit inside the dark `FieldBackground`** → If contrast/sizing looks off at `controlSize(.small)`, fall back to `.stepperField` or adjust padding. Cosmetic, not blocking.
- **The window fix unblocks the natural-language and notes editors too** (same root cause) → Confirm those also focus during verification, even though the reported symptoms were title + date/time.
