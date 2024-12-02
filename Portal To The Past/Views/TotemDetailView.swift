import SwiftUI
import AVKit

struct TotemDetailView: View {
    let totem: Location
    @Environment(\.dismiss) private var dismiss
    @State private var isPlayingAudio = false
    @State private var showingVideo = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 顶部导航栏
                HStack {
                    Button(action: { dismiss() }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding()
                .background(Color(.systemBackground))
                
                // 图腾图片
                Image(totem.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .background(Color(.secondarySystemBackground))
                
                // 媒体控制按钮
                HStack(spacing: 20) {
                    Spacer()
                    
                    // 语音解说按钮
                    Button(action: {
                        isPlayingAudio.toggle()
                        // TODO: 实现音频播放逻辑
                    }) {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: isPlayingAudio ? "pause.fill" : "play.fill")
                                    .foregroundColor(.white)
                            )
                    }
                    
                    // 视频播放按钮
                    Button(action: {
                        showingVideo = true
                    }) {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 44, height: 44)
                            .overlay(
                                Image(systemName: "video.fill")
                                    .foregroundColor(.white)
                            )
                    }
                }
                .padding(.horizontal)
                .offset(y: -22)
                
                // 详细内容
                TotemDetailContent(
                    totem: totem,
                    isPlayingAudio: $isPlayingAudio,
                    onPlayVideo: { showingVideo = true }
                )
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
        .fullScreenCover(isPresented: $showingVideo) {
            VideoPlayerView(
                videoFileName: totem.videoFileName,
                isPresented: $showingVideo
            )
        }
        .onDisappear {
            // 停止音频播放
            audioPlayer?.stop()
            isPlayingAudio = false
        }
    }
}

// 更新视频播放器视图
struct VideoPlayerView: View {
    let videoFileName: String
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: videoFileName, withExtension: "mp4") ?? URL(string: "about:blank")!))
                .edgesIgnoringSafeArea(.all)
                .navigationBarItems(
                    leading: Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                )
        }
    }
}

#Preview {
    TotemDetailView(totem: Location.sampleLocations[0])
} 