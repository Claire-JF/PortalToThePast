import Foundation

struct Location: Identifiable {
    let id: UUID
    let name: String
    let description: String
    let imageName: String
    let shortDescription: String
    let coordinates: (Double, Double)
    let audioFileName: String
    let videoFileName: String
    let detailedDescription: String
    let yearCreated: String
    let height: String
    let material: String
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        imageName: String,
        shortDescription: String,
        coordinates: (Double, Double),
        audioFileName: String,
        videoFileName: String,
        detailedDescription: String,
        yearCreated: String,
        height: String,
        material: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageName = imageName
        self.shortDescription = shortDescription
        self.coordinates = coordinates
        self.audioFileName = audioFileName
        self.videoFileName = videoFileName
        self.detailedDescription = detailedDescription
        self.yearCreated = yearCreated
        self.height = height
        self.material = material
    }
}

extension Location {
    static let sampleLocations = [
        Location(
            name: "Mortuary Pole",
            description: "A significant mortuary pole showcasing Haida craftsmanship and cultural practices.",
            imageName: "mortuary_pole",
            shortDescription: "Historic Mortuary Pole",
            coordinates: (52.0975, -131.2209),
            audioFileName: "mortuary_pole_audio",
            videoFileName: "mortuary_pole_video",
            detailedDescription: "This mortuary pole, standing as a testament to Haida craftsmanship, was created to honor deceased chiefs and noble family members. The pole features intricate carvings of traditional crests and tells the story of the deceased's lineage and achievements.",
            yearCreated: "Circa 1880",
            height: "40 feet",
            material: "Red Cedar"
        ),
        Location(
            name: "Memorial Pole",
            description: "An ornate memorial pole representing Haida family histories and achievements.",
            imageName: "memorial_pole",
            shortDescription: "Family Memorial Pole",
            coordinates: (52.0980, -131.2215),
            audioFileName: "memorial_pole_audio",
            videoFileName: "memorial_pole_video",
            detailedDescription: "This memorial pole was raised to commemorate important events and achievements in Haida history. The intricate carvings depict family crests, mythological beings, and significant events, serving as both a historical record and a work of art.",
            yearCreated: "Circa 1890",
            height: "35 feet",
            material: "Red Cedar"
        ),
        Location(
            name: "House Frontal Pole",
            description: "A magnificent house frontal pole displaying family crests and social status.",
            imageName: "house_pole",
            shortDescription: "Traditional House Pole",
            coordinates: (52.0985, -131.2220),
            audioFileName: "house_pole_audio",
            videoFileName: "house_pole_video",
            detailedDescription: "This house frontal pole once stood at the entrance of a noble family's longhouse. The pole's designs represent the family's ancestral rights, privileges, and social status within the community. Each figure carved into the pole tells a specific story about the family's history and connections.",
            yearCreated: "Circa 1870",
            height: "45 feet",
            material: "Red Cedar"
        )
    ]
} 