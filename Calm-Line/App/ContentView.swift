import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = QuoteViewModel()
  @State private var isSharing = false
  @AppStorage(SettingsKeys.hapticsEnabled) private var hapticsEnabled = true
  @AppStorage(SettingsKeys.showAuthor) private var showAuthor = true

  var body: some View {
    TabView {
      NavigationStack {
        todayView
          .navigationTitle("Calm-Line")
          .navigationBarTitleDisplayMode(.large)
      }
      .tabItem {
        Label("Today", systemImage: "sun.max")
      }

      NavigationStack {
        FavoritesView(viewModel: viewModel, showAuthor: showAuthor)
      }
      .tabItem {
        Label("Favorites", systemImage: "heart.fill")
      }

      NavigationStack {
        SettingsView(viewModel: viewModel)
      }
      .tabItem {
        Label("Settings", systemImage: "gearshape")
      }
    }
  }

  private var todayView: some View {
    ZStack {
      LinearGradient(
        colors: [
          Color(.systemBackground),
          Color(.secondarySystemBackground)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
      .ignoresSafeArea()

      VStack(spacing: 18) {
        Spacer(minLength: 0)

        QuoteCardView(quote: viewModel.quote, showAuthor: showAuthor)
          .id(viewModel.quote.id)
          .transition(.opacity.combined(with: .scale(scale: 0.98)))

        actionsRow

        Spacer(minLength: 0)
      }
      .padding()
    }
    .sheet(isPresented: $isSharing) {
      ShareSheet(items: [viewModel.shareText(for: viewModel.quote, showAuthor: showAuthor)])
    }
  }

  private var actionsRow: some View {
    HStack(spacing: 12) {
      Button {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
          viewModel.refresh()
        }
        if hapticsEnabled { Haptics.lightImpact() }
      } label: {
        Label("Refresh", systemImage: "arrow.clockwise")
      }
      .accessibilityLabel("Refresh quote")

      Button {
        viewModel.toggleFavoriteForCurrentQuote()
        if hapticsEnabled { Haptics.lightImpact() }
      } label: {
        Label("Favorite", systemImage: viewModel.isCurrentFavorite ? "heart.fill" : "heart")
      }
      .accessibilityLabel(viewModel.isCurrentFavorite ? "Remove from favorites" : "Add to favorites")

      Button {
        isSharing = true
      } label: {
        Label("Share", systemImage: "square.and.arrow.up")
      }
      .accessibilityLabel("Share quote")
    }
    .labelStyle(.iconOnly)
    .font(.title3.weight(.semibold))
    .buttonStyle(.bordered)
    .controlSize(.large)
  }
}

#Preview {
  ContentView()
}


