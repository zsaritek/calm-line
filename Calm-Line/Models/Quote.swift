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
    Quote(text: "Breathe. You’re here.", author: "Unknown", tags: ["breath", "present"]),
    Quote(text: "Slow is smooth. Smooth is fast.", author: "Unknown", tags: ["pace"]),
    Quote(text: "One thing at a time.", author: "Unknown", tags: ["focus"]),
    Quote(text: "Notice what is already okay.", author: "Unknown", tags: ["gratitude"]),
    Quote(text: "Start where you are.", author: "Pema Chödrön", tags: ["start"]),
    Quote(text: "Small steps still move you forward.", author: "Unknown", tags: ["progress"]),
    Quote(text: "Let your shoulders drop.", author: "Unknown", tags: ["body"]),
    Quote(text: "You can do hard things gently.", author: "Unknown", tags: ["strength"]),
    Quote(text: "This moment is enough.", author: "Unknown", tags: ["present"]),
    Quote(text: "Make space. Then decide.", author: "Unknown", tags: ["clarity"]),
    Quote(text: "Where attention goes, energy flows.", author: "James Redfield", tags: ["attention"]),
    Quote(text: "Rest is part of the work.", author: "Unknown", tags: ["rest"]),
    Quote(text: "Be kind to your mind.", author: "Unknown", tags: ["kindness"]),
    Quote(text: "Simplicity is the ultimate sophistication.", author: "Leonardo da Vinci", tags: ["simplicity"]),
    Quote(text: "The quieter you become, the more you can hear.", author: "Ram Dass", tags: ["stillness"]),
    Quote(text: "You don’t have to be perfect to be at peace.", author: "Unknown", tags: ["peace"]),
    Quote(text: "A calm mind brings inner strength.", author: "Dalai Lama", tags: ["mind"]),
    Quote(text: "Do less. Do it better.", author: "Unknown", tags: ["simplicity"]),
    Quote(text: "Let it be easy today.", author: "Unknown", tags: ["ease"]),
    Quote(text: "Your only job is to show up.", author: "Unknown", tags: ["presence"]),
    Quote(text: "Peace begins with a smile.", author: "Mother Teresa", tags: ["peace"]),
    Quote(text: "What you seek is seeking you.", author: "Rumi", tags: ["curiosity"]),
    Quote(text: "The best time to relax is when you don’t have time for it.", author: "Sydney J. Harris", tags: ["stress"]),
    Quote(text: "The present moment is the only moment available to us.", author: "Thich Nhat Hanh", tags: ["present"]),
    Quote(text: "Nothing can bring you peace but yourself.", author: "Ralph Waldo Emerson", tags: ["peace"])
  ]
}


