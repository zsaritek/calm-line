import SwiftUI

struct ContentView: View {
  private let quote = Quote.samples.first ?? Quote(text: "Welcome to Calm-Line.", author: "Unknown")

  var body: some View {
    NavigationStack {
      ZStack {
        LinearGradient(
          colors: [
            Color(.systemBackground),
            Color(.secondarySystemBackground)
          ],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        VStack(spacing: 18) {
          Text("Calm-Line")
            .font(.largeTitle.bold())
            .frame(maxWidth: .infinity, alignment: .leading)

          Spacer(minLength: 0)

          QuoteCardView(quote: quote, showAuthor: true)

          Spacer(minLength: 0)
        }
        .padding()
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ContentView()
}


