# quick-event-entry-ui Specification

## Purpose
TBD: created by archiving change add-quick-event-main-page-dark. Update Purpose after archive.
## Requirements
### Requirement: Native dark quick event page
The system SHALL provide a native SwiftUI macOS quick event entry page that closely matches the provided "Quick Event Main Page - Dark" Stitch mockup.

#### Scenario: Page renders as dark floating panel
- **WHEN** the quick event entry page is shown
- **THEN** it displays a compact dark floating panel with rounded corners, subtle border, natural-language input area, details section, and footer actions.

### Requirement: Empty initial event details
The system SHALL render editable event fields empty by default, except date controls which SHALL initialize to today's date.

#### Scenario: Initial field values
- **WHEN** the quick event entry page first appears
- **THEN** natural-language input, title, location, and notes fields are empty, and the date control uses today's date.

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

### Requirement: Footer actions
The system SHALL show settings, cancel, and create event controls in the panel footer.

#### Scenario: Footer controls are visible
- **WHEN** the quick event entry page is shown
- **THEN** the footer includes a settings icon control, a cancel control, and a primary create event control.

### Requirement: Create event writes to Calendar
The system SHALL create a timed macOS Calendar event on the default calendar when the user activates the create event control, using the entered title and the selected date combined with the start and end time controls.

#### Scenario: Create event writes a timed event
- **WHEN** the user enters an event title, sets the date and times, and activates the create event control
- **THEN** a timed event with that title is written to the default macOS Calendar on the selected date for the selected start and end times.

#### Scenario: Missing Calendar access is surfaced
- **WHEN** the user activates the create event control and Calendar access is not granted
- **THEN** the panel surfaces an error and no event is written.

#### Scenario: Missing title is surfaced
- **WHEN** the user activates the create event control with an empty title
- **THEN** the panel surfaces an error and no event is written.

### Requirement: Keyboard-focusable panel
The quick event entry panel's window SHALL be able to become the key window so its controls can host the first responder and receive keyboard input, while the panel SHALL remain visually borderless with no titlebar chrome.

#### Scenario: Panel can receive keyboard focus
- **WHEN** the quick event entry panel is shown and the user clicks a text or date control
- **THEN** the window becomes key and the control receives keyboard focus.

#### Scenario: Panel stays visually borderless
- **WHEN** the quick event entry panel is shown
- **THEN** no titlebar, title text, or standard window buttons are visible.

