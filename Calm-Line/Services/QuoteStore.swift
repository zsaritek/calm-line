import Foundation

final class QuoteStore {
  private let quotes: [Quote]
  private let defaults: UserDefaults

  init(quotes: [Quote] = Quote.samples, defaults: UserDefaults = .standard) {
    self.quotes = quotes
    self.defaults = defaults
  }

  func quoteForToday() -> Quote {
    guard !quotes.isEmpty else {
      return Quote(text: "Welcome to Calm-Line.", author: "Unknown")
    }

    let key = dailyKey(for: Date())
    if let storedIndex = defaults.object(forKey: key) as? Int,
       quotes.indices.contains(storedIndex) {
      return quotes[storedIndex]
    }

    let index = stableHash(key) % quotes.count
    defaults.set(index, forKey: key)
    return quotes[index]
  }

  func randomQuote(excluding current: Quote) -> Quote {
    guard quotes.count > 1 else { return current }

    for _ in 0..<5 {
      if let candidate = quotes.randomElement(), candidate != current {
        return candidate
      }
    }

    // Fallback: deterministic next item.
    if let idx = quotes.firstIndex(of: current) {
      return quotes[(idx + 1) % quotes.count]
    }
    return quotes.randomElement() ?? current
  }

  // MARK: - Private

  private func dailyKey(for date: Date) -> String {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = .current
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: date)
  }

  /// A tiny stable hash (String.hashValue is process-randomized, so we don't use it).
  private func stableHash(_ string: String) -> Int {
    var hash = 0
    for scalar in string.unicodeScalars {
      hash = (hash &* 31) &+ Int(scalar.value)
    }
    return abs(hash)
  }
}


