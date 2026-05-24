import AppKit

struct QuickCalLaunchConfiguration {
  let activationPolicy: NSApplication.ActivationPolicy
  let activatesIgnoringOtherApps: Bool

  static let `default` = QuickCalLaunchConfiguration(
    activationPolicy: .regular,
    activatesIgnoringOtherApps: true)
}

final class QuickCalAppDelegate: NSObject, NSApplicationDelegate {
  private let configuration: QuickCalLaunchConfiguration

  override init() {
    configuration = .default
    super.init()
  }

  init(configuration: QuickCalLaunchConfiguration) {
    self.configuration = configuration
    super.init()
  }

  func applicationDidFinishLaunching(_ notification: Notification) {
    NSApplication.shared.setActivationPolicy(configuration.activationPolicy)

    guard configuration.activatesIgnoringOtherApps else {
      return
    }

    if #available(macOS 14, *) {
      NSApplication.shared.activate()
    } else {
      NSApplication.shared.activate(ignoringOtherApps: true)
    }
  }
}
