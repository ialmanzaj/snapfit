import SwiftUI
import UIKit // Added for UIBlurEffect and UIViewRepresentable

struct GlassBottomSheet: View {
    var body: some View {
        VStack(spacing: 20) {
            // Handle Indicator
            Capsule()
                .fill(Color.white.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)
            
            // Top Icons Row
            HStack {
                
                Spacer()
                Image(systemName: "square.grid.2x2")
                    .imageScale(.large)
              
            }
            .foregroundColor(.white)
            .padding(.horizontal, 30)

            // Stats Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                StatView(label: "Distance", value: "10.0mi")
                StatView(label: "Pace", value: "10.0mi") // Example value consistency
                StatView(label: "Time", value: "1h 30m")
                StatView(label: "Deviation", value: "100 ft")
                StatView(label: "Heart Rate", value: "139bpm")
                StatView(label: "Calories", value: "1300 cal")
            }
            .padding(.horizontal, 16)

            // Removed Spacer() here to let VStack control padding/spacing around GlassBottomSheet content
        }
        .frame(maxWidth: .infinity)
        // Removed fixed frame height - let the content and detents determine height
        .padding(.bottom, 20)
        .background(
            BlurView(style: .systemUltraThinMaterialDark)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                 // Consider adjusting shadow based on new presentation
                .shadow(color: Color.black.opacity(0.2), radius: 15, y: -3)
        )
        // Ensures the background respects the safe area, especially at .large detent
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Preview for GlassBottomSheet
#if DEBUG
struct GlassBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        GlassBottomSheet()
            .padding() // Add some padding around for better visualization in preview
            .background(Color.blue) // Add a contrasting background for visibility
    }
}
#endif

// Reusable Stat Block
struct StatView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.6))
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

// Blur background helper
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
} 