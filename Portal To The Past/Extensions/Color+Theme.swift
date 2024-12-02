import SwiftUI

extension Color {
    static let theme = ThemeColors()
}

struct ThemeColors {
    let olive = Color(hex: "606C38").opacity(0.9)
    let forest = Color(hex: "283618")
    let cream = Color(hex: "FEFAE0")
    let copper = Color(hex: "DDA15E").opacity(0.95)
    let rust = Color(hex: "BC4619")
    
    let background = Color(hex: "FEFAE0")
    let cardBackground = Color(hex: "FFFFFF")
    let primaryText = Color(hex: "283618").opacity(0.95)
    let secondaryText = Color(hex: "606C38").opacity(0.85)
    let accent = Color(hex: "DDA15E")
    let buttonBackground = Color(hex: "606C38").opacity(0.95)
    let buttonText = Color(hex: "FEFAE0")
    
    let divider = Color(hex: "283618").opacity(0.1)
    let shadow = Color(hex: "283618").opacity(0.15)
    let highlight = Color(hex: "DDA15E").opacity(0.2)
    let error = Color(hex: "BC4619")
    let success = Color(hex: "606C38")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
} 