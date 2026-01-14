import SwiftUI

struct FavoritesView: View {
  @ObservedObject var viewModel: QuoteViewModel
  @State private var selectedQuote: Quote?
  let showAuthor: Bool

  var body: some View {
    ZStack {
      AppBackground()

      List {
        if viewModel.favoriteQuotes.isEmpty {
          Section {
            ContentUnavailableView(
              "No favorites yet",
              systemImage: "heart",
              description: Text("Tap the heart on a quote to save it here.")
            )
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
          }
        } else {
          Section {
            ForEach(viewModel.favoriteQuotes) { quote in
              QuoteCardView(quote: quote, showAuthor: showAuthor, isCompact: true)
                .listRowInsets(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 18))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                  selectedQuote = quote
                }
                .accessibilityLabel("Favorite quote")
                .accessibilityValue("\(quote.text), \(quote.author)")
            }
            .onDelete { indexSet in
              viewModel.removeFavorites(at: indexSet)
            }
          }
        }
      }
      .scrollContentBackground(.hidden)
      .listStyle(.plain)
      .navigationTitle("Favorites")
      .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
      .toolbarBackground(.visible, for: .navigationBar)
      .sheet(item: $selectedQuote) { quote in
        FavoriteDetailView(quote: quote, viewModel: viewModel, showAuthor: showAuthor)
      }
    }
  }
}

#Preview {
  NavigationStack {
    FavoritesView(viewModel: QuoteViewModel(), showAuthor: true)
  }
}


