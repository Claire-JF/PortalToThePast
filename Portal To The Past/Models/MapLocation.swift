import Foundation

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let coordinates: (Double, Double)
    let panoramaImageName: String
    let markerImageName: String
}

extension MapLocation {
    static let mapLocations = [
        MapLocation(
            name: "SGang Gwaay Village",
            description: "Ancient village site with standing totem poles",
            coordinates: (52.0975, -131.2209),
            panoramaImageName: "panorama_village",
            markerImageName: "marker_village"
        ),
        MapLocation(
            name: "Mortuary Poles",
            description: "Historic mortuary pole collection",
            coordinates: (52.0980, -131.2215),
            panoramaImageName: "panorama_mortuary",
            markerImageName: "marker_mortuary"
        ),
        MapLocation(
            name: "Memorial Garden",
            description: "Memorial poles and artifacts",
            coordinates: (52.0985, -131.2220),
            panoramaImageName: "panorama_garden",
            markerImageName: "marker_garden"
        )
    ]
} 