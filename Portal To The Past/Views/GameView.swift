import SwiftUI

struct GameView: View {
    let levels = GameLevel.levels
    @State private var animateCards = false
    @State private var selectedLevel: GameLevel?
    private let theme = AppTheme.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    levelsSection
                }
                .padding(.vertical)
            }
            .background(theme.colors.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("TOTEM RESTORATION")
                        .font(.headline)
                        .foregroundColor(theme.colors.forest)
                }
            }
            .onAppear(perform: animateContent)
            .onDisappear {
                animateCards = false
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            theme.titleStyle(Text("Restore & Preserve"))
            
            theme.bodyStyle(Text("Experience the art of totem pole restoration through interactive cleaning activities. Learn about traditional preservation techniques while helping to maintain these sacred cultural artifacts."))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal)
        .padding(.top)
        .opacity(animateCards ? 1 : 0)
        .offset(y: animateCards ? 0 : 20)
    }
    
    private var levelsSection: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 20) {
            ForEach(Array(levels.enumerated()), id: \.element.id) { index, level in
                levelCard(for: level, at: index)
            }
        }
    }
    
    private func levelCard(for level: GameLevel, at index: Int) -> some View {
        Group {
            if !level.isLocked {
                NavigationLink(destination: GameLevelView(level: level)) {
                    LevelCard(level: level)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                LevelCard(level: level)
            }
        }
        .padding(.horizontal)
        .opacity(animateCards ? 1 : 0)
        .offset(y: animateCards ? 0 : 50)
        .animation(
            .spring(response: 0.5, dampingFraction: 0.8)
            .delay(Double(index) * 0.1),
            value: animateCards
        )
    }
    
    private func animateContent() {
        withAnimation(.easeOut(duration: 0.5)) {
            animateCards = true
        }
    }
}

#Preview {
    GameView()
} 