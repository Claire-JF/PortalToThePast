import SwiftUI

struct LevelCard: View {
    let level: GameLevel
    private let theme = AppTheme.shared
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 20)
                .fill(theme.colors.cardBackground)
                .shadow(color: theme.colors.shadow, radius: 10)
            
            // 内容
            VStack(spacing: 12) {
                // 关卡号和难度
                HStack {
                    Text("Level \(level.number)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(theme.colors.forest)
                    
                    Spacer()
                    
                    difficultyBadge(level.difficulty)
                }
                
                // 3D模型预览
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(theme.colors.background)
                        .frame(height: 160)
                    
                    if level.isLocked {
                        VStack(spacing: 8) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 30))
                                .symbolEffect(.bounce, value: isPressed)
                                .foregroundColor(theme.colors.olive)
                            Text("Score \(level.requiredScore) to unlock")
                                .font(.caption)
                                .foregroundColor(theme.colors.olive)
                        }
                    } else {
                        Image(systemName: "cube.fill")
                            .font(.system(size: 40))
                            .foregroundColor(theme.colors.olive)
                            .symbolEffect(.bounce, value: isPressed)
                    }
                }
                
                // 关卡信息
                VStack(alignment: .leading, spacing: 4) {
                    Text(level.name)
                        .font(.headline)
                        .foregroundColor(theme.colors.forest)
                    
                    Text(level.description)
                        .font(.caption)
                        .foregroundColor(theme.colors.olive)
                        .lineLimit(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
        }
        .opacity(level.isLocked ? 0.7 : 1)
    }
    
    private func difficultyBadge(_ difficulty: GameLevel.Difficulty) -> some View {
        let (color, background) = difficultyColors(difficulty)
        return Text(difficulty.rawValue)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(background)
            .foregroundColor(color)
            .clipShape(Capsule())
    }
    
    private func difficultyColors(_ difficulty: GameLevel.Difficulty) -> (Color, Color) {
        switch difficulty {
        case .easy:
            return (theme.colors.success, theme.colors.success.opacity(0.2))
        case .medium:
            return (theme.colors.copper, theme.colors.copper.opacity(0.2))
        case .hard:
            return (theme.colors.rust, theme.colors.rust.opacity(0.2))
        }
    }
} 