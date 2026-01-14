import SwiftUI

struct FavoritesView: View {
  @ObservedObject var viewModel: QuoteViewModel

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
  }
}

#Preview {
  NavigationStack {
    FavoritesView(viewModel: QuoteViewModel())
  }
}


