import SwiftUI

@main
struct AwakeApp: App {
    @StateObject private var store = CoffeeStore()
    @StateObject private var blindsup = BlindsStore()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
            .environmentObject(blindsup)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                blindsup.blindsup = false
            }
            if phase == .inactive {
                blindsup.blindsup = true
            }
        }
    }
}
class BlindsStore: ObservableObject {
    @Published var blindsup: Bool

    init(blindsup: Bool = false) {
        self.blindsup = blindsup
    }
}

struct BlindsUp {
    var blindsup: Bool
}
