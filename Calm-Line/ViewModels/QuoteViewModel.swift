import Foundation

@MainActor
final class QuoteViewModel: ObservableObject {
  @Published private(set) var quote: Quote
  @Published private(set) var favoriteIDs: Set<UUID>

  private let store: QuoteStore
  private let favorites: FavoritesStore

  init(store: QuoteStore = QuoteStore(), favorites: FavoritesStore = FavoritesStore()) {
    self.store = store
    self.favorites = favorites
    self.quote = store.quoteForToday()
    self.favoriteIDs = favorites.favoriteIDs
  }

  func refresh() {
    quote = store.randomQuote(excluding: quote)
  }

  var isCurrentFavorite: Bool {
    favoriteIDs.contains(quote.id)
  }

  var favoriteQuotes: [Quote] {
    store.allQuotes.filter { favoriteIDs.contains($0.id) }
  }

  func toggleFavoriteForCurrentQuote() {
    favorites.toggle(quote.id)
    favoriteIDs = favorites.favoriteIDs
  }

  func removeFavorites(at indexSet: IndexSet) {
    let current = favoriteQuotes
    for index in indexSet {
      guard current.indices.contains(index) else { continue }
      favorites.remove(current[index].id)
    }
    favoriteIDs = favorites.favoriteIDs
  }
}


