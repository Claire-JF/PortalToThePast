import SwiftUI
import MapKit

struct PanoramaView: View {
    @State private var selectedLocation: MapLocation?
    @State private var showingPanorama = false
    let locations = MapLocation.mapLocations
    private let theme = AppTheme.shared
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                // 地图视图
                MapView(
                    locations: locations,
                    selectedLocation: $selectedLocation
                )
                .edgesIgnoringSafeArea(.all)
                
                // 选中位置的信息卡片
                if let location = selectedLocation {
                    LocationInfoCard(
                        location: location,
                        onViewPanorama: {
                            showingPanorama = true
                        }
                    )
                    .transition(.move(edge: .bottom))
                }
            }
            .navigationTitle("Explore Ninstints")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("EXPLORE NINSTINTS")
                        .font(.headline)
                        .foregroundColor(theme.colors.forest)
                }
            }
            .fullScreenCover(isPresented: $showingPanorama) {
                if let location = selectedLocation {
                    PanoramaViewer(
                        imageName: location.panoramaImageName,
                        isPresented: $showingPanorama
                    )
                }
            }
        }
    }
}

// 分离信息卡片为独立组件
struct LocationInfoCard: View {
    let location: MapLocation
    let onViewPanorama: () -> Void
    private let theme = AppTheme.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(theme.colors.forest)
            
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(theme.colors.olive)
            
            Button(action: onViewPanorama) {
                HStack {
                    Image(systemName: "panorama")
                    Text("View 360° Panorama")
                }
                .font(.headline)
                .foregroundColor(theme.colors.cream)
                .frame(maxWidth: .infinity)
                .padding()
                .background(theme.colors.copper)
                .cornerRadius(12)
            }
        }
        .padding()
        .background(theme.colors.cardBackground)
        .cornerRadius(16)
        .shadow(color: theme.colors.shadow, radius: 8)
        .padding()
    }
}

#Preview {
    PanoramaView()
} 