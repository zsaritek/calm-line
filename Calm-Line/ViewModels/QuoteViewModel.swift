import Foundation

@MainActor
final class QuoteViewModel: ObservableObject {
  @Published private(set) var quote: Quote

  private let store: QuoteStore

  init(store: QuoteStore = QuoteStore()) {
    self.store = store
    self.quote = store.quoteForToday()
  }

  func refresh() {
    quote = store.randomQuote(excluding: quote)
  }
}


