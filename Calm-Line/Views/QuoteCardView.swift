import SwiftUI

struct QuoteCardView: View {
  let quote: Quote
  let showAuthor: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("“\(quote.text)”")
        .font(.title3.weight(.semibold))
        .foregroundStyle(.primary)
        .accessibilityLabel("Quote")
        .accessibilityValue(quote.text)

      if showAuthor {
        Text(quote.author)
          .font(.callout.weight(.medium))
          .foregroundStyle(.secondary)
          .accessibilityLabel("Author")
          .accessibilityValue(quote.author)
      }
    }
    .padding(18)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    .overlay(
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .strokeBorder(.quaternary, lineWidth: 1)
    )
    .accessibilityElement(children: .combine)
  }
}

#Preview {
  ZStack {
    LinearGradient(colors: [.blue.opacity(0.18), .purple.opacity(0.12)], startPoint: .topLeading, endPoint: .bottomTrailing)
      .ignoresSafeArea()
    QuoteCardView(quote: Quote.samples[0], showAuthor: true)
      .padding()
  }
}


