import SwiftUI
import SceneKit

struct ModelViewer: View {
    let modelName: String
    @State private var isShowingOriginal = true
    @State private var opacity: Double = 1.0
    @Binding var cleanProgress: Double
    private let theme = AppTheme.shared
    @State private var hasSwitched = false
    @State private var transparency: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            SceneKitView(isShowingOriginal: $isShowingOriginal, cleanProgress: $cleanProgress, transparency: $transparency)
                .opacity(opacity)
                .background(theme.colors.background)
                .edgesIgnoringSafeArea(.all)
        }
        .onChange(of: cleanProgress) { newValue in
            if newValue >= 50.0 && !hasSwitched {
                hasSwitched = true
                withAnimation(.easeInOut(duration: 1.0)) {
                    opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isShowingOriginal = false
                    opacity = 1.0
                }
            }
            
            if newValue >= 75.0 {
                let targetTransparency = CGFloat(1.0 - (newValue - 75.0) / 25.0)
                withAnimation(.easeInOut(duration: 0.1)) {
                    transparency = targetTransparency
                }
            }
        }
    }
}

struct SceneKitView: UIViewRepresentable {
    @Binding var isShowingOriginal: Bool
    @Binding var cleanProgress: Double
    @Binding var transparency: CGFloat
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.backgroundColor = .clear
        
        let scene = SCNScene()
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.intensity = 100
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        view.scene = scene
        setupScene(view: view)
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        setupScene(view: uiView)
    }
    
    private func setupScene(view: SCNView) {
        if let modelScene = SCNScene(named: "TotemDAE.dae") {
            print("Successfully loaded TotemDAE.dae")
            
            guard let modelNode = modelScene.rootNode.childNodes.first else {
                print("No nodes found in model")
                return
            }
            
            let boundingBox = modelNode.boundingBox
            let modelHeight = boundingBox.max.y - boundingBox.min.y
            let baseScale: Float = (2.0 / modelHeight) * 0.3
            modelNode.scale = SCNVector3(baseScale, baseScale, baseScale)
            
            modelNode.position = SCNVector3(
                0,
                (-boundingBox.min.y * baseScale) - 1.0,
                0
            )
            
            // 创建新的材质
            let material = SCNMaterial()
            material.lightingModel = .blinn
            
            // 加载贴图
            let textureName = isShowingOriginal ? "level1_original" : "level1_decay"
            if let textureURL = Bundle.main.url(forResource: textureName, withExtension: "png"),
               let textureImage = UIImage(contentsOfFile: textureURL.path) {
                
                // 设置贴图
                material.diffuse.contents = textureImage
                material.diffuse.wrapS = .repeat
                material.diffuse.wrapT = .repeat
                material.diffuse.minificationFilter = .linear
                material.diffuse.magnificationFilter = .linear
                material.diffuse.mipFilter = .linear
                
                // 设置透明度
                material.transparency = transparency
                
                print("Material set up successfully with \(textureName)")
            }
            
            // 应用材质
            modelNode.geometry?.firstMaterial = material
            
            // 清除现有节点并添加新节点
            view.scene?.rootNode.childNodes.forEach { $0.removeFromParentNode() }
            view.scene?.rootNode.addChildNode(modelNode)
            print("Model added to scene")
        } else {
            print("Failed to load model: TotemDAE.dae")
        }
    }
}

#Preview {
    ModelViewer(modelName: "mortuary_pole_3d", cleanProgress: .constant(0))
} 
