import AppKit
import XCTest

@testable import QuickCalApp

final class QuickEventEntryViewTests: XCTestCase {
  func test_givenPanelMetrics_whenRead_thenWidthAndHeightMatchPanelOnlyWindow() {
    // Arrange, Act
    let size = QuickEventEntryPanelMetrics.size

    // Assert
    XCTAssertEqual(size.width, 460)
    XCTAssertEqual(size.height, 640)
  }

  func test_givenPanelOnlyWindowConfiguration_whenInspected_thenItUsesBorderlessStyle() {
    // Arrange, Act
    let configuration = PanelOnlyWindowConfiguration.quickEventEntry

    // Assert
    XCTAssertEqual(configuration.styleMask, [.borderless])
  }

  func test_givenPanelOnlyWindowConfiguration_whenInspected_thenItUsesTransparentNonOpaqueBackground() {
    // Arrange, Act
    let configuration = PanelOnlyWindowConfiguration.quickEventEntry

    // Assert
    XCTAssertEqual(configuration.backgroundColor, .clear)
    XCTAssertFalse(configuration.isOpaque)
  }

  func test_givenPanelOnlyWindowConfiguration_whenInspected_thenItDisablesExternalWindowShadow() {
    // Arrange, Act
    let configuration = PanelOnlyWindowConfiguration.quickEventEntry

    // Assert
    XCTAssertFalse(configuration.hasShadow)
  }

  func test_givenPanelOnlyWindowConfiguration_whenInspected_thenItMatchesPanelMetrics() {
    // Arrange, Act
    let configuration = PanelOnlyWindowConfiguration.quickEventEntry

    // Assert
    XCTAssertEqual(configuration.contentSize, QuickEventEntryPanelMetrics.size)
  }

  func test_givenPanelOnlyWindowConfiguration_whenInspected_thenItCanMoveByWindowBackground() {
    // Arrange, Act
    let configuration = PanelOnlyWindowConfiguration.quickEventEntry

    // Assert
    XCTAssertTrue(configuration.isMovableByWindowBackground)
  }

  func test_givenQuickEventEntryView_whenRendered_thenItDoesNotUseDecorativeBackdrop() {
    // Arrange
    let view = QuickEventEntryView()

    // Act
    let bodyType = String(describing: type(of: view.body))

    // Assert
    XCTAssertFalse(bodyType.contains("VisualBackdrop"))
  }
}
