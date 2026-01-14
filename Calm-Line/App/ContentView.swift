import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = QuoteViewModel()

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
        FavoritesView(viewModel: viewModel)
      }
      .tabItem {
        Label("Favorites", systemImage: "heart.fill")
      }

      NavigationStack {
        SettingsView()
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

        QuoteCardView(quote: viewModel.quote, showAuthor: true)
          .id(viewModel.quote.id)
          .transition(.opacity.combined(with: .scale(scale: 0.98)))

        actionsRow

        Spacer(minLength: 0)
      }
      .padding()
    }
  }

  private var actionsRow: some View {
    HStack(spacing: 12) {
      Button {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
          viewModel.refresh()
        }
      } label: {
        Label("Refresh", systemImage: "arrow.clockwise")
      }
      .accessibilityLabel("Refresh quote")

      Button {
        viewModel.toggleFavoriteForCurrentQuote()
      } label: {
        Label("Favorite", systemImage: viewModel.isCurrentFavorite ? "heart.fill" : "heart")
      }
      .accessibilityLabel(viewModel.isCurrentFavorite ? "Remove from favorites" : "Add to favorites")

      Button { } label: {
        Label("Share", systemImage: "square.and.arrow.up")
      }
      .disabled(true)
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


