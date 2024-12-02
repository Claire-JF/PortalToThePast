import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    let locations = Location.sampleLocations
    private let theme = AppTheme.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Search Bar
                    SearchBar(searchText: $searchText)
                        .padding(.top, 8)
                    
                    // Who Are We Section
                    VStack(alignment: .leading, spacing: 12) {
                        theme.titleStyle(Text("Who Are We?"))
                        
                        theme.bodyStyle(Text("Portal to the Past is an immersive solution bringing SGang Gwaay (Ninstints) and its rich Haida heritage to life. Our main features include a 360 panorama, audio guide, voice narration from Indigenous perspectives, and gamified activities, making history immersive, engaging, and accessible to all."))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal)
                    
                    // Info Session Section
                    VStack(alignment: .leading, spacing: 16) {
                        theme.titleStyle(Text("Info Session"))
                            .padding(.horizontal)
                        
                        ForEach(locations) { location in
                            LocationCard(location: location)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 4) {
                        Text("PORTAL")
                            .font(.headline)
                            .foregroundColor(theme.colors.forest)
                        Text("TO THE PAST")
                            .font(.headline)
                            .foregroundColor(theme.colors.olive)
                    }
                }
            }
            .background(theme.colors.background)
        }
    }
}

#Preview {
    HomeView()
} 
