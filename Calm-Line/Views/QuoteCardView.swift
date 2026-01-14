import SwiftUI

struct QuoteCardView: View {
  let quote: Quote
  let showAuthor: Bool
  var isCompact: Bool = false

  @Environment(\.colorScheme) private var scheme

  var body: some View {
    ZStack {
      cardBackground
      content
    }
    .shadow(color: .black.opacity(shadowOpacity), radius: 14, x: 0, y: 9)
    .accessibilityElement(children: .combine)
  }

  // MARK: - Subviews (kept small to help the Swift compiler)

  private var content: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("“\(quote.text)”")
        .font(isCompact ? .body.weight(.semibold) : .title2.weight(.semibold))
        .kerning(isCompact ? 0 : 0.2)
        .lineSpacing(isCompact ? 2 : 4)
        .foregroundStyle(.primary)
        .accessibilityLabel("Quote")
        .accessibilityValue(quote.text)

      if showAuthor {
        Text(quote.author)
          .font((isCompact ? Font.footnote : Font.callout).weight(.medium))
          .foregroundStyle(isCompact ? AnyShapeStyle(.secondary) : AnyShapeStyle(.tint))
          .accessibilityLabel("Author")
          .accessibilityValue(quote.author)
      }
    }
    .padding(isCompact ? 16 : 22)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private var cardBackground: some View {
    let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

    return ZStack {
      shape
        .fill(Color(.systemBackground).opacity(backgroundOpacity))

      shape
        .fill(.ultraThinMaterial)
        .opacity(glassOpacity)

      shape
        .strokeBorder(Color.white.opacity(borderOpacity), lineWidth: 1)
    }
  }

  private var cornerRadius: CGFloat { isCompact ? 18 : 24 }
  private var backgroundOpacity: CGFloat { scheme == .dark ? 0.70 : 0.90 }
  private var borderOpacity: CGFloat { scheme == .dark ? 0.10 : 0.35 }
  private var shadowOpacity: CGFloat { scheme == .dark ? 0.35 : 0.12 }
  private var glassOpacity: CGFloat { isCompact ? 0.08 : 0.12 }
}

#Preview {
  ZStack {
    AppBackground()
    QuoteCardView(quote: Quote.samples[0], showAuthor: true)
      .padding()
  }
}


