import SwiftUI

struct FavoriteDetailView: View {
  let quote: Quote
  @ObservedObject var viewModel: QuoteViewModel
  let showAuthor: Bool

  @Environment(\.dismiss) private var dismiss
  @State private var isSharing = false
  @AppStorage(SettingsKeys.hapticsEnabled) private var hapticsEnabled = true

  var body: some View {
    NavigationStack {
      ZStack {
        AppBackground()

        VStack(spacing: 18) {
          QuoteCardView(quote: quote, showAuthor: showAuthor)
            .padding(.top, 10)

          HStack(spacing: 14) {
            Button {
              isSharing = true
            } label: {
              Image(systemName: "square.and.arrow.up")
            }
            .buttonStyle(CircleIconButtonStyle(fill: .cyan))
            .accessibilityLabel("Share quote")

            Button(role: .destructive) {
              viewModel.unfavorite(quote)
              if hapticsEnabled { Haptics.lightImpact() }
              dismiss()
            } label: {
              Image(systemName: "heart.slash")
            }
            .buttonStyle(CircleIconButtonStyle(fill: .pink))
            .accessibilityLabel("Remove from favorites")
          }

          Spacer(minLength: 0)
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 22)
      }
      .navigationTitle("Quote")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Done") { dismiss() }
        }
      }
    }
    .sheet(isPresented: $isSharing) {
      ShareSheet(items: [viewModel.shareText(for: quote, showAuthor: showAuthor)])
    }
  }
}

#Preview {
  FavoriteDetailView(quote: Quote.samples[0], viewModel: QuoteViewModel(), showAuthor: true)
}


