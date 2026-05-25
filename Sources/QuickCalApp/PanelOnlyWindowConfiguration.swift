import AppKit
import SwiftUI

enum QuickEventEntryPanelMetrics {
  static let width: CGFloat = 460
  static let height: CGFloat = 640
  static let cornerRadius: CGFloat = 12
  static let size = CGSize(width: width, height: height)
}

struct PanelOnlyWindowConfiguration {
  let styleMask: NSWindow.StyleMask
  let backgroundColor: NSColor
  let isOpaque: Bool
  let hasShadow: Bool
  let isMovableByWindowBackground: Bool
  let contentSize: CGSize

  static let quickEventEntry = PanelOnlyWindowConfiguration(
    styleMask: [.borderless],
    backgroundColor: .clear,
    isOpaque: false,
    hasShadow: false,
    isMovableByWindowBackground: true,
    contentSize: QuickEventEntryPanelMetrics.size)

  func apply(to window: NSWindow) {
    window.styleMask = styleMask
    window.backgroundColor = backgroundColor
    window.isOpaque = isOpaque
    window.hasShadow = hasShadow
    window.isMovableByWindowBackground = isMovableByWindowBackground
    window.setContentSize(contentSize)
    window.minSize = contentSize
    window.maxSize = contentSize
  }
}

struct PanelOnlyWindowConfigurator: NSViewRepresentable {
  let configuration: PanelOnlyWindowConfiguration

  init(configuration: PanelOnlyWindowConfiguration = .quickEventEntry) {
    self.configuration = configuration
  }

  func makeNSView(context: Context) -> PanelOnlyWindowConfiguringView {
    PanelOnlyWindowConfiguringView(configuration: configuration)
  }

  func updateNSView(_ nsView: PanelOnlyWindowConfiguringView, context: Context) {
    nsView.configuration = configuration
    nsView.applyConfiguration()
  }
}

final class PanelOnlyWindowConfiguringView: NSView {
  var configuration: PanelOnlyWindowConfiguration

  init(configuration: PanelOnlyWindowConfiguration) {
    self.configuration = configuration
    super.init(frame: .zero)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidMoveToWindow() {
    super.viewDidMoveToWindow()
    applyConfiguration()
  }

  func applyConfiguration() {
    guard let window else {
      return
    }

    configuration.apply(to: window)
  }
}
