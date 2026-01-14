import SwiftUI

struct FavoriteDetailView: View {
  let quote: Quote
  @ObservedObject var viewModel: QuoteViewModel
  let showAuthor: Bool

  @Environment(\.dismiss) private var dismiss
  @State private var isSharing = false

  var body: some View {
    NavigationStack {
      VStack(spacing: 16) {
        QuoteCardView(quote: quote, showAuthor: showAuthor)

        HStack(spacing: 12) {
          Button {
            isSharing = true
          } label: {
            Label("Share", systemImage: "square.and.arrow.up")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)

          Button(role: .destructive) {
            viewModel.unfavorite(quote)
            dismiss()
          } label: {
            Label("Unfavorite", systemImage: "heart.slash")
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.bordered)
        }

        Spacer(minLength: 0)
      }
      .padding()
      .navigationTitle("Quote")
      .navigationBarTitleDisplayMode(.inline)
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


