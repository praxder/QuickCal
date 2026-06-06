## MODIFIED Requirements

### Requirement: Visible detail controls
The system SHALL include visible controls for title, date, time, all-day state, location, calendar, repeat, reminder, and notes. Each text and date/time control SHALL accept keyboard focus and direct keyboard input when activated.

#### Scenario: Detail controls are available
- **WHEN** the user views the details section
- **THEN** controls for title, date, time, all-day state, location, calendar, repeat, reminder, and notes are visible and editable.

#### Scenario: Text fields accept focus and typing
- **WHEN** the user clicks the event title, location, or notes control
- **THEN** the control becomes focused and accepts typed characters.

#### Scenario: Date and time fields accept direct entry
- **WHEN** the user clicks a component of the date or time control
- **THEN** that component becomes editable and accepts typed digits to set the value directly.

## ADDED Requirements

### Requirement: Keyboard-focusable panel
The quick event entry panel's window SHALL be able to become the key window so its controls can host the first responder and receive keyboard input, while the panel SHALL remain visually borderless with no titlebar chrome.

#### Scenario: Panel can receive keyboard focus
- **WHEN** the quick event entry panel is shown and the user clicks a text or date control
- **THEN** the window becomes key and the control receives keyboard focus.

#### Scenario: Panel stays visually borderless
- **WHEN** the quick event entry panel is shown
- **THEN** no titlebar, title text, or standard window buttons are visible.
