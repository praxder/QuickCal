import SwiftUI

@main
struct QuickCalApp: App {
  var body: some Scene {
    WindowGroup {
      QuickEventEntryView()
    }
    .defaultSize(width: 700, height: 640)
    .windowResizability(.contentSize)
  }
}
