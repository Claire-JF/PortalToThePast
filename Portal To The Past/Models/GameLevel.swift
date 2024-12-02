import SwiftUI
import Foundation

struct GameLevel: Identifiable {
    let id: UUID = UUID()
    let number: Int
    let name: String
    let description: String
    let difficulty: Difficulty
    let isLocked: Bool
    let requiredScore: Int
    let modelName: String
    
    enum Difficulty: String {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        
        var color: Color {
            switch self {
            case .easy: return .green
            case .medium: return .orange
            case .hard: return .red
            }
        }
    }
}

extension GameLevel {
    static let levels = [
        GameLevel(
            number: 1,
            name: "What will happen in 10 years...?",
            description: "Apply effects to see totem decay",
            difficulty: .easy,
            isLocked: false,
            requiredScore: 0,
            modelName: "mortuary_pole_3d"
        ),
        GameLevel(
            number: 2,
            name: "Memorial Pole Revival",
            description: "Uncover the hidden details of the memorial pole",
            difficulty: .medium,
            isLocked: true,
            requiredScore: 100,
            modelName: "memorial_pole_3d"
        ),
        GameLevel(
            number: 3,
            name: "House Pole Preservation",
            description: "Preserve the intricate carvings of the house pole",
            difficulty: .hard,
            isLocked: true,
            requiredScore: 200,
            modelName: "house_pole_3d"
        )
    ]
} 