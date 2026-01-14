import SwiftUI

struct SettingsView: View {
  var body: some View {
    Form {
      Section {
        Text("Settings will land in the final commit.")
          .foregroundStyle(.secondary)
      }
    }
    .navigationTitle("Settings")
  }
}

#Preview {
  NavigationStack {
    SettingsView()
  }
}


