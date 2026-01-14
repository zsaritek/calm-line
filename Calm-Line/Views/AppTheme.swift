import SwiftUI

enum AppTheme {
  static let headerGradient = LinearGradient(
    colors: [
      Color.indigo,
      Color.cyan
    ],
    startPoint: .leading,
    endPoint: .trailing
  )

  static func backgroundGradient(for scheme: ColorScheme) -> LinearGradient {
    if scheme == .dark {
      return LinearGradient(
        colors: [
          Color.indigo.opacity(0.55),
          Color.cyan.opacity(0.25),
          Color.black.opacity(0.90)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
      )
    }

    return LinearGradient(
      colors: [
        Color.indigo.opacity(0.22),
        Color.cyan.opacity(0.16),
        Color.white.opacity(0.70)
      ],
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
  }
}

struct AppBackground: View {
  @Environment(\.colorScheme) private var scheme

  var body: some View {
    AppTheme.backgroundGradient(for: scheme)
      .ignoresSafeArea()
      .overlay {
        // Subtle depth so content "sits" above the gradient.
        Rectangle()
          .fill(.ultraThinMaterial)
          .opacity(scheme == .dark ? 0.12 : 0.06)
          .ignoresSafeArea()
      }
  }
}

struct CircleIconButtonStyle: ButtonStyle {
  let fill: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundStyle(.white)
      .font(.title3.weight(.semibold))
      .frame(width: 52, height: 52)
      .background(
        Circle()
          .fill(fill)
          .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 8)
      )
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.spring(response: 0.22, dampingFraction: 0.85), value: configuration.isPressed)
  }
}


