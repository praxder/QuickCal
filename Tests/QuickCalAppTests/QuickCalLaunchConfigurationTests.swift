import AppKit
import XCTest

@testable import QuickCalApp

final class QuickCalLaunchConfigurationTests: XCTestCase {
  func test_givenSwiftUIAdaptor_whenCreatingDelegateWithNSObjectInitializer_thenDelegateIsCreated() {
    // Arrange
    let delegateType: NSObject.Type = QuickCalAppDelegate.self

    // Act
    let delegate = delegateType.init()

    // Assert
    XCTAssertTrue(delegate is QuickCalAppDelegate)
  }

  func test_givenSwiftPackageExecutable_whenLaunching_thenAppUsesRegularActivationPolicy() {
    // Arrange, Act
    let configuration = QuickCalLaunchConfiguration.default

    // Assert
    XCTAssertEqual(configuration.activationPolicy, .regular)
  }

  func test_givenSwiftPackageExecutable_whenWindowAppears_thenAppActivatesIgnoringOtherApps() {
    // Arrange, Act
    let configuration = QuickCalLaunchConfiguration.default

    // Assert
    XCTAssertTrue(configuration.activatesIgnoringOtherApps)
  }
}
