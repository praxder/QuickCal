## ADDED Requirements

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
The system SHALL include visible controls for title, date, time, all-day state, location, calendar, repeat, reminder, and notes.

#### Scenario: Detail controls are available
- **WHEN** the user views the details section
- **THEN** controls for title, date, time, all-day state, location, calendar, repeat, reminder, and notes are visible and editable.

### Requirement: Footer actions
The system SHALL show settings, cancel, and create event controls in the panel footer.

#### Scenario: Footer controls are visible
- **WHEN** the quick event entry page is shown
- **THEN** the footer includes a settings icon control, a cancel control, and a primary create event control.

### Requirement: No Calendar side effects
The system SHALL NOT create or modify macOS Calendar events from this page in this change.

#### Scenario: Create event is inert
- **WHEN** the user activates the create event control
- **THEN** no event is written to the macOS Calendar app.
