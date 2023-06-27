import SwiftUI

@main
struct AwakeApp: App {
    @StateObject private var store = CoffeeStore()
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
