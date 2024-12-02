import SwiftUI

struct PanoramaViewer: View {
    let imageName: String
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // 背景色
            Color.gray.opacity(0.3)
            
            // 全景图
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            } else {
                // 如果图片加载失败，显示占位符
                VStack {
                    Image(systemName: "photo")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("Image not found: \(imageName)")
                        .foregroundColor(.gray)
                }
            }
            
            // 返回按钮
            VStack {
                HStack {
                    Button(action: { 
                        withAnimation {
                            isPresented = false 
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 20, weight: .bold))
                            Text("Back")
                                .font(.system(size: 20, weight: .bold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(.black.opacity(0.75))
                                .shadow(color: .black.opacity(0.3), radius: 10)
                        )
                    }
                    .padding(.top, 60)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
        .onAppear {
            print("Attempting to load image: \(imageName)")
        }
    }
}

// 预览
#Preview {
    PanoramaViewer(imageName: "panorama_placeholder", isPresented: .constant(true))
} 