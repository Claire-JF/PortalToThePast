import Foundation

enum CleaningTool: CaseIterable {
    case rain
    case wind
    case fungusMicrobe
    
    var icon: String {
        switch self {
        case .rain:
            return "cloud.rain"
        case .wind:
            return "wind"
        case .fungusMicrobe:
            return "leaf"
        }
    }
    
    var description: String {
        switch self {
        case .rain:
            return "Rain"
        case .wind:
            return "Wind"
        case .fungusMicrobe:
            return "Fungus & Microbe"
        }
    }
    
    var cleaningEfficiency: Double {
        switch self {
        case .rain:
            return 0.5
        case .wind:
            return 0.3
        case .fungusMicrobe:
            return 0.7
        }
    }
    
    var effectRadius: CGFloat {
        switch self {
        case .rain:
            return 30
        case .wind:
            return 40
        case .fungusMicrobe:
            return 35
        }
    }
} 