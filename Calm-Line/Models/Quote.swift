import Foundation

struct Quote: Identifiable, Hashable, Codable {
  let id: UUID
  let text: String
  let author: String
  let tags: [String]

  init(id: UUID = UUID(), text: String, author: String, tags: [String] = []) {
    self.id = id
    self.text = text
    self.author = author
    self.tags = tags
  }
}

extension Quote {
  // Local seed data (25+) shipped with the app.
  static let samples: [Quote] = [
    Quote(id: uuid("00000000-0000-0000-0000-000000000001"), text: "Breathe. You’re here.", author: "Unknown", tags: ["breath", "present"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000002"), text: "Slow is smooth. Smooth is fast.", author: "Unknown", tags: ["pace"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000003"), text: "One thing at a time.", author: "Unknown", tags: ["focus"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000004"), text: "Notice what is already okay.", author: "Unknown", tags: ["gratitude"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000005"), text: "Start where you are.", author: "Pema Chödrön", tags: ["start"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000006"), text: "Small steps still move you forward.", author: "Unknown", tags: ["progress"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000007"), text: "Let your shoulders drop.", author: "Unknown", tags: ["body"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000008"), text: "You can do hard things gently.", author: "Unknown", tags: ["strength"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000009"), text: "This moment is enough.", author: "Unknown", tags: ["present"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000A"), text: "Make space. Then decide.", author: "Unknown", tags: ["clarity"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000B"), text: "Where attention goes, energy flows.", author: "James Redfield", tags: ["attention"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000C"), text: "Rest is part of the work.", author: "Unknown", tags: ["rest"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000D"), text: "Be kind to your mind.", author: "Unknown", tags: ["kindness"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000E"), text: "Simplicity is the ultimate sophistication.", author: "Leonardo da Vinci", tags: ["simplicity"]),
    Quote(id: uuid("00000000-0000-0000-0000-00000000000F"), text: "The quieter you become, the more you can hear.", author: "Ram Dass", tags: ["stillness"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000010"), text: "You don’t have to be perfect to be at peace.", author: "Unknown", tags: ["peace"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000011"), text: "A calm mind brings inner strength.", author: "Dalai Lama", tags: ["mind"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000012"), text: "Do less. Do it better.", author: "Unknown", tags: ["simplicity"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000013"), text: "Let it be easy today.", author: "Unknown", tags: ["ease"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000014"), text: "Your only job is to show up.", author: "Unknown", tags: ["presence"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000015"), text: "Peace begins with a smile.", author: "Mother Teresa", tags: ["peace"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000016"), text: "What you seek is seeking you.", author: "Rumi", tags: ["curiosity"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000017"), text: "The best time to relax is when you don’t have time for it.", author: "Sydney J. Harris", tags: ["stress"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000018"), text: "The present moment is the only moment available to us.", author: "Thich Nhat Hanh", tags: ["present"]),
    Quote(id: uuid("00000000-0000-0000-0000-000000000019"), text: "Nothing can bring you peace but yourself.", author: "Ralph Waldo Emerson", tags: ["peace"])
  ]

  private static func uuid(_ string: String) -> UUID {
    // Stable IDs are important for persistence (favorites).
    UUID(uuidString: string)!
  }
}


