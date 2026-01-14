import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = QuoteViewModel()

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

          QuoteCardView(quote: viewModel.quote, showAuthor: true)
            .id(viewModel.quote.id)
            .transition(.opacity.combined(with: .scale(scale: 0.98)))

          Button {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
              viewModel.refresh()
            }
          } label: {
            Label("Refresh", systemImage: "arrow.clockwise")
              .font(.headline)
              .padding(.vertical, 10)
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
          .tint(.primary.opacity(0.85))
          .accessibilityLabel("Refresh quote")

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


