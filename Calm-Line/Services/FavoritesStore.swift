import Foundation

final class FavoritesStore {
  private(set) var favoriteIDs: Set<UUID>

  private let defaults: UserDefaults
  private let key = "favoriteQuoteIDs"

  init(defaults: UserDefaults = .standard) {
    self.defaults = defaults
    self.favoriteIDs = []
    self.favoriteIDs = load()
  }

  func contains(_ id: UUID) -> Bool {
    favoriteIDs.contains(id)
  }

  func toggle(_ id: UUID) {
    if favoriteIDs.contains(id) {
      favoriteIDs.remove(id)
    } else {
      favoriteIDs.insert(id)
    }
    persist()
  }

  func remove(_ id: UUID) {
    favoriteIDs.remove(id)
    persist()
  }

  func reset() {
    favoriteIDs = []
    defaults.removeObject(forKey: key)
  }

  // MARK: - Private

  private func load() -> Set<UUID> {
    let strings = defaults.stringArray(forKey: key) ?? []
    return Set(strings.compactMap(UUID.init(uuidString:)))
  }

  private func persist() {
    defaults.set(favoriteIDs.map(\.uuidString).sorted(), forKey: key)
  }
}


