import SwiftUI

struct TotemDetailContent: View {
    let totem: Location
    @Binding var isPlayingAudio: Bool
    let onPlayVideo: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // 基本信息
            VStack(alignment: .leading, spacing: 8) {
                Text(totem.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(totem.shortDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // 详细描述
            Text(totem.detailedDescription)
                .font(.body)
                .foregroundColor(.secondary)
            
            // 规格信息
            VStack(alignment: .leading, spacing: 16) {
                specificationRow(title: "Created", value: totem.yearCreated)
                specificationRow(title: "Height", value: totem.height)
                specificationRow(title: "Material", value: totem.material)
            }
            .padding(.vertical)
        }
        .padding()
    }
    
    private func specificationRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .fontWeight(.medium)
            Spacer()
        }
    }
} 