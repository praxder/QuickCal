import SwiftUI

@main
struct QuickCalApp: App {
  @NSApplicationDelegateAdaptor(QuickCalAppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      QuickEventEntryView()
        .background {
          PanelOnlyWindowConfigurator()
        }
    }
    .defaultSize(width: QuickEventEntryPanelMetrics.width, height: QuickEventEntryPanelMetrics.height)
    .windowResizability(.contentSize)
  }
}
