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
          .navigationBarHidden(true)
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
    .tint(.indigo)
  }

  private var todayView: some View {
    ZStack {
      AppBackground()

      VStack(spacing: 20) {
        header
          .padding(.top, 8)

        Spacer(minLength: 6)

        QuoteCardView(quote: viewModel.quote, showAuthor: showAuthor, isCompact: false)
          .id(viewModel.quote.id)
          .transition(.opacity.combined(with: .scale(scale: 0.97)))
          .accessibilityHint("Quote of the day")

        actionsRow

        Spacer(minLength: 10)
      }
      .padding(.horizontal, 22)
      .padding(.bottom, 22)
    }
    .sheet(isPresented: $isSharing) {
      ShareSheet(items: [viewModel.shareText(for: viewModel.quote, showAuthor: showAuthor)])
    }
  }

  private var header: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("Calm-Line")
        .font(.system(.largeTitle, design: .rounded).weight(.bold))
        .foregroundStyle(AppTheme.headerGradient)

      Text("One quote for today")
        .font(.subheadline.weight(.medium))
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 18)
  }

  private var actionsRow: some View {
    HStack(spacing: 14) {
      Button {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
          viewModel.refresh()
        }
        if hapticsEnabled { Haptics.lightImpact() }
      } label: {
        Image(systemName: "arrow.clockwise")
      }
      .accessibilityLabel("Refresh quote")
      .buttonStyle(CircleIconButtonStyle(fill: .indigo))

      Button {
        viewModel.toggleFavoriteForCurrentQuote()
        if hapticsEnabled { Haptics.lightImpact() }
      } label: {
        Image(systemName: viewModel.isCurrentFavorite ? "heart.fill" : "heart")
      }
      .accessibilityLabel(viewModel.isCurrentFavorite ? "Remove from favorites" : "Add to favorites")
      .buttonStyle(CircleIconButtonStyle(fill: viewModel.isCurrentFavorite ? .pink : .indigo.opacity(0.85)))

      Button {
        isSharing = true
      } label: {
        Image(systemName: "square.and.arrow.up")
      }
      .accessibilityLabel("Share quote")
      .buttonStyle(CircleIconButtonStyle(fill: .cyan))
    }
    .frame(maxWidth: .infinity, alignment: .center)
  }
}

#Preview {
  ContentView()
}


