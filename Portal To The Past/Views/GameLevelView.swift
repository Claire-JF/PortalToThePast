import SwiftUI
import SceneKit

// 可拖拽的工具按钮组件
struct DraggableToolButton: View {
    let tool: CleaningTool
    let isSelected: Bool
    let onDragStarted: (CGPoint) -> Void
    let onDragChanged: (CGPoint) -> Void
    let onDragEnded: (CGPoint) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: tool.icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? .orange : .primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.1), radius: 5)
                )
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .named("dragSpace"))
                        .onChanged { value in
                            if value.translation == .zero {
                                let buttonCenter = CGPoint(
                                    x: geometry.frame(in: .named("dragSpace")).midX,
                                    y: geometry.frame(in: .named("dragSpace")).midY
                                )
                                onDragStarted(buttonCenter)
                            }
                            onDragChanged(value.location)
                        }
                        .onEnded { value in
                            onDragEnded(value.location)
                        }
                )
        }
    }
}

struct BreathingAnimation: ViewModifier {
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isAnimating ? 0.6 : 1.0)  // 透明度变化
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                ) {
                    isAnimating = true
                }
            }
    }
}

struct GameLevelView: View {
    let level: GameLevel
    @Environment(\.dismiss) private var dismiss
    @State private var cleanProgress: Double = 0
    @State private var showingSuccessAlert = false
    @State private var selectedTool: CleaningTool?
    @State private var toolPosition: CGPoint = .zero
    @State private var isDragging = false
    @State private var lastDragPosition: CGPoint?
    private let theme = AppTheme.shared
    
    var body: some View {
        ZStack(alignment: .trailing) {
            modelView
            toolbarView
            dragToolView
            successAlertView
        }
        .navigationTitle(level.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Exit") {
                    dismiss()
                }
                .foregroundColor(theme.colors.forest)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // 添加游戏相关的动作
                }) {
                    Label("Game", systemImage: "gamecontroller")  // 使用游戏控制器图标
                }
                .foregroundColor(theme.colors.forest)
            }
        }
        .coordinateSpace(name: "dragSpace")
    }
    
    // 3D模型视图
    private var modelView: some View {
        ModelViewer(
            modelName: level.modelName,
            cleanProgress: $cleanProgress
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    // 工具栏视图
    private var toolbarView: some View {
        VStack(spacing: 0) {
            // 顶部进度条
            progressView
                .padding(.top, 40)
            
            Spacer()
            
            // 右下角工具栏
            HStack {
                Spacer()  // 添加这个将工具栏推到最右边
                VStack(spacing: 16) {
                    ForEach(CleaningTool.allCases, id: \.self) { tool in
                        toolButton(for: tool)
                    }
                }
            }
            .padding(.bottom, 40)
        }
    }
    
    // 工具按钮列表
    private var toolButtons: some View {
        ForEach(CleaningTool.allCases, id: \.self) { tool in
            toolButton(for: tool)
        }
    }
    
    // 单个工具按钮
    private func toolButton(for tool: CleaningTool) -> some View {
        VStack(spacing: 4) {
            DraggableToolButton(
                tool: tool,
                isSelected: selectedTool == tool,
                onDragStarted: { startDragging(tool: tool, at: $0) },
                onDragChanged: { updateDragging(at: $0) },
                onDragEnded: { endDragging(at: $0) }
            )
            .frame(width: 50, height: 50)
            
            Text(tool.description)
                .font(.caption2)
                .foregroundColor(theme.colors.forest)
                .multilineTextAlignment(.center)
                .frame(width: 70)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(theme.colors.cream.opacity(0.9))
                .shadow(color: theme.colors.shadow, radius: 5)
        )
    }
    
    // 进度指示器
    private var progressView: some View {
        VStack(spacing: 8) {
            // 添加 "Decay Progress" 文本
            Text("Decay Progress")
                .font(.custom("Chalkboard SE", size: 20))  // 使用手写风格字体并减小字号
                .italic()
                .foregroundColor(theme.colors.olive)
            
            // 显示百分比
            Text("\(Int(cleanProgress))%")
                .font(.title3.bold())
                .foregroundColor(theme.colors.forest)
            
            // 进度条
            ProgressView(value: cleanProgress, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: theme.colors.olive))  // 设置进度条颜色为墨绿色
                .frame(width: 240)
                .scaleEffect(y: 2)
            
            // 起始和结束时间
            HStack {
                Text("Now")
                    .font(.subheadline)
                    .foregroundColor(theme.colors.olive)
                Spacer()
                Text("2034")
                    .font(.subheadline)
                    .foregroundColor(theme.colors.olive)
            }
            .frame(width: 240)
            
            // 添加提示文本
            Text("Drag & Swipe Effects To See Decay")
                .font(.system(size: 16, weight: .medium))  // 增大字体
                .foregroundColor(theme.colors.olive)
                .padding(.vertical, 8)  // 增加垂直内边距
                .padding(.horizontal, 24)  // 增加水平内边距
                .background(  // 添加背景框
                    RoundedRectangle(cornerRadius: 8)
                        .fill(theme.colors.cream.opacity(0.6))
                        .shadow(color: theme.colors.shadow, radius: 3)
                )
                .padding(.top, 12)
                .italic()
                .scaleEffect(1.0 + (cleanProgress > 0 ? 0.1 : 0))
                .opacity(0.9)
                .modifier(BreathingAnimation())
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.colors.cream.opacity(0.9))
                .shadow(color: theme.colors.shadow, radius: 5)
        )
        .frame(maxWidth: .infinity)
    }
    
    // 辅助函数：格式化月份
    private func formatMonth(_ month: Int) -> String {
        let months = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        ]
        return months[month - 1]
    }
    
    // 拖动中的工具视图
    private var dragToolView: some View {
        Group {
            if let tool = selectedTool, isDragging {
                Circle()
                    .fill(theme.colors.copper.opacity(0.8))
                    .frame(width: tool.effectRadius * 2)
                    .overlay(
                        Image(systemName: tool.icon)
                            .foregroundColor(.white)
                    )
                    .position(toolPosition)
                    .allowsHitTesting(false)
            }
        }
    }
    
    // 成功提示视图
    private var successAlertView: some View {
        Group {
            if showingSuccessAlert {
                // 添加一个半透明的背景遮罩
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                
                // 提示框
                VStack(spacing: 20) {
                    // 更新后的标题
                    Text("THEY'LL DISAPPEAR")
                        .font(.title)  // 调小字号
                        .fontWeight(.bold)
                        .foregroundColor(theme.colors.forest)
                        .padding(.bottom, 8)
                    
                    // 更新后的提示文本
                    Text("Due to the inevitable erosion by wind, rain, and microbes, most wooden totem poles will disappear in ten years. Protecting indigenous heritage is urgent.")
                        .font(.body)
                        .foregroundColor(theme.colors.olive)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(theme.colors.cream)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(theme.colors.olive)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(theme.colors.cream)
                        .shadow(color: theme.colors.shadow, radius: 10)
                )
                .padding(.horizontal, 32)
                .transition(.scale.combined(with: .opacity))
                .zIndex(2)
                // 使用这些修饰符确保居中
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .position(
                    x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2
                )
            }
        }
    }
    
    // MARK: - Drag Gesture Methods
    private func startDragging(tool: CleaningTool, at position: CGPoint) {
        selectedTool = tool
        isDragging = true
        toolPosition = position
        lastDragPosition = position
    }
    
    private func updateDragging(at position: CGPoint) {
        toolPosition = position
        
        guard let lastPosition = lastDragPosition,
              let tool = selectedTool else { return }
        
        let dragDistance = sqrt(
            pow(position.x - lastPosition.x, 2) +
            pow(position.y - lastPosition.y, 2)
        )
        let increment = dragDistance * tool.cleaningEfficiency * 0.02  // 减慢增长速度
        
        withAnimation(.linear(duration: 0.2)) {  // 增加动画持续时间
            cleanProgress = min(cleanProgress + increment, 100)
            if cleanProgress >= 100 {
                showingSuccessAlert = true
            }
        }
        
        lastDragPosition = position
    }
    
    private func endDragging(at position: CGPoint) {
        isDragging = false
        selectedTool = nil
        lastDragPosition = nil
    }
}

#Preview {
    NavigationView {
        GameLevelView(level: GameLevel.levels[0])
    }
} 
