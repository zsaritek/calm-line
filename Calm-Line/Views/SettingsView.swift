import SwiftUI

struct SettingsView: View {
  @ObservedObject var viewModel: QuoteViewModel

  @AppStorage(SettingsKeys.hapticsEnabled) private var hapticsEnabled = true
  @AppStorage(SettingsKeys.showAuthor) private var showAuthor = true

  var body: some View {
    Form {
      Section("Preferences") {
        Toggle("Haptics", isOn: $hapticsEnabled)
          .accessibilityLabel("Haptics")

        Toggle("Show Author", isOn: $showAuthor)
          .accessibilityLabel("Show author")
      }

      Section {
        Button(role: .destructive) {
          viewModel.resetFavorites()
        } label: {
          Text("Reset Favorites")
        }
        .accessibilityLabel("Reset favorites")
      }
    }
    .navigationTitle("Settings")
  }
}

#Preview {
  NavigationStack {
    SettingsView(viewModel: QuoteViewModel())
  }
}


