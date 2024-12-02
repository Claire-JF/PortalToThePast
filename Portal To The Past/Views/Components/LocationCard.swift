import SwiftUI

struct LocationCard: View {
    let location: Location
    @State private var showingDetail = false
    private let theme = AppTheme.shared
    
    var body: some View {
        Button(action: { showingDetail = true }) {
            VStack(alignment: .leading, spacing: 0) {
                // Image Container
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .fill(theme.colors.olive.opacity(0.1))
                        .frame(height: 200)
                        .overlay {
                            Text("Image Placeholder")
                                .foregroundColor(theme.colors.olive)
                        }
                    
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, theme.colors.forest.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                // Content Container
                VStack(alignment: .leading, spacing: 8) {
                    Text(location.name)
                        .font(.headline)
                        .foregroundColor(theme.colors.forest)
                    
                    Text(location.shortDescription)
                        .font(.subheadline)
                        .foregroundColor(theme.colors.olive)
                    
                    Text(location.description)
                        .font(.subheadline)
                        .foregroundColor(theme.colors.olive)
                        .lineLimit(2)
                    
                    HStack {
                        Button(action: {}) {
                            Text("Learn more")
                                .font(.subheadline.weight(.medium))
                                .foregroundColor(theme.colors.copper)
                        }
                        
                        Spacer()
                        
                        theme.captionStyle(Text(String(format: "%.4f, %.4f", 
                             location.coordinates.0, 
                             location.coordinates.1)))
                    }
                }
                .padding(16)
            }
            .background(theme.colors.cream)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(color: theme.colors.forest.opacity(0.1), radius: 8, x: 0, y: 4)
            .padding(.horizontal)
        }
        .sheet(isPresented: $showingDetail) {
            TotemDetailView(totem: location)
        }
    }
} 