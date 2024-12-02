import SwiftUI

struct AppTheme {
    static let shared = AppTheme()
    
    // 主题颜色
    let colors = Color.theme
    
    // 卡片样式
    func cardStyle<Content: View>(_ content: Content) -> some View {
        content
            .background(colors.cream)
            .cornerRadius(16)
            .shadow(color: colors.forest.opacity(0.1), radius: 10)
    }
    
    // 主按钮样式
    func primaryButtonStyle<Content: View>(_ content: Content) -> some View {
        content
            .foregroundColor(colors.cream)
            .padding()
            .background(colors.olive)
            .cornerRadius(12)
    }
    
    // 次要按钮样式
    func secondaryButtonStyle<Content: View>(_ content: Content) -> some View {
        content
            .foregroundColor(colors.olive)
            .padding()
            .background(colors.cream)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(colors.olive, lineWidth: 1)
            )
    }
    
    // 标题文本样式
    func titleStyle(_ text: Text) -> some View {
        text
            .font(.title2.weight(.bold))
            .foregroundColor(colors.forest)
    }
    
    // 正文文本样式
    func bodyStyle(_ text: Text) -> some View {
        text
            .font(.body)
            .foregroundColor(colors.forest)
    }
    
    // 次要文本样式
    func captionStyle(_ text: Text) -> some View {
        text
            .font(.caption)
            .foregroundColor(colors.olive)
    }
} 