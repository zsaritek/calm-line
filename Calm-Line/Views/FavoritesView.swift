import SwiftUI

struct FavoritesView: View {
  @ObservedObject var viewModel: QuoteViewModel
  @State private var selectedQuote: Quote?

  var body: some View {
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
            QuoteCardView(quote: quote, showAuthor: true, isCompact: true)
              .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
              .listRowSeparator(.hidden)
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
    .listStyle(.plain)
    .navigationTitle("Favorites")
    .sheet(item: $selectedQuote) { quote in
      FavoriteDetailView(quote: quote, viewModel: viewModel)
    }
  }
}

#Preview {
  NavigationStack {
    FavoritesView(viewModel: QuoteViewModel())
  }
}


