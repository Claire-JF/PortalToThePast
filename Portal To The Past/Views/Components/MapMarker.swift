import SwiftUI

struct MapMarker: View {
    let location: MapLocation
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .orange : .gray)
                
                Text(location.name)
                    .font(.caption)
                    .foregroundColor(isSelected ? .orange : .gray)
                    .fontWeight(isSelected ? .bold : .regular)
                    .multilineTextAlignment(.center)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.1), radius: 4)
            )
        }
    }
} 