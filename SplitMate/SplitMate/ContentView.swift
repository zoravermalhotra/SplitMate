import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("SplitMate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Split bills.")
                    .foregroundStyle(.secondary)
                
                Button("Create a bill:") {
                    print("Create bill button pressed")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
