import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    private let theme = AppTheme.shared
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(theme.colors.olive)
            
            TextField("Explore SGang Gwaay (Ninstints)", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(theme.colors.forest)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(theme.colors.olive)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.colors.cream)
                .shadow(color: theme.colors.forest.opacity(0.1), radius: 5)
        )
        .padding(.horizontal)
    }
} 