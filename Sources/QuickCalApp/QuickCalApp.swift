import SwiftUI

@main
struct QuickCalApp: App {
  @NSApplicationDelegateAdaptor(QuickCalAppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      QuickEventEntryView()
    }
    .defaultSize(width: 700, height: 640)
    .windowResizability(.contentSize)
  }
}
