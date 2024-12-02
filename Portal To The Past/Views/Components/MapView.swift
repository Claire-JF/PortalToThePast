import SwiftUI
import MapKit

struct MapView: View {
    let locations: [MapLocation]
    @Binding var selectedLocation: MapLocation?
    
    // 地图状态
    @State private var camera: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 52.0980,  // SGang Gwaay 中心位置
            longitude: -131.2215
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,  // 初始缩放级别
            longitudeDelta: 0.01
        )
    ))
    
    var body: some View {
        Map(position: $camera) {
            ForEach(locations) { location in
                Annotation(
                    location.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: location.coordinates.0,
                        longitude: location.coordinates.1
                    ),
                    anchor: .bottom
                ) {
                    MapMarker(
                        location: location,
                        isSelected: selectedLocation?.id == location.id
                    ) {
                        withAnimation {
                            selectedLocation = location
                            camera = .region(MKCoordinateRegion(
                                center: CLLocationCoordinate2D(
                                    latitude: location.coordinates.0,
                                    longitude: location.coordinates.1
                                ),
                                span: MKCoordinateSpan(
                                    latitudeDelta: 0.005,
                                    longitudeDelta: 0.005
                                )
                            ))
                        }
                    }
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControls {
            MapCompass()
            MapScaleView()
            MapUserLocationButton()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    camera = .region(MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: 52.0980,
                            longitude: -131.2215
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.0099,
                            longitudeDelta: 0.0099
                        )
                    ))
                }
            }
        }
    }
}

// 预览
#Preview {
    MapView(
        locations: MapLocation.mapLocations,
        selectedLocation: .constant(nil)
    )
} 