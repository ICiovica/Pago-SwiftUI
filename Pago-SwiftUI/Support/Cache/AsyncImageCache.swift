//
//  AsyncImageCache.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 17/12/2023.
//

import SwiftUI

struct AsyncImageCache<Content>: View where Content: View {
    private let url: URL?
    private let placeholderInitials: String
    private let content: (Image) -> Content
    
    init(
        url: URL?,
        placeholderInitials: String,
        @ViewBuilder content: @escaping (Image) -> Content
    ) {
        self.url = url
        self.placeholderInitials = placeholderInitials
        self.content = content
    }
    
    var body: some View {
        if let url, let cached = ImageCache[url] {
            content(cached)
        } else {
            asyncImageBlock()
        }
    }
}

// MARK: - Views
private extension AsyncImageCache {
    @MainActor private func asyncImageBlock() -> some View {
        AsyncImage(url: url) { image in
            if let url {
                ImageCache[url] = image
            }
            return content(image)
        } placeholder: { placeholderVw }
    }
    
    var placeholderVw: some View {
        ZStack {
            Circle()
                .fill(Color.listRowBackground)
                .frame(width: UserConstants.imageFrame, height: UserConstants.imageFrame)
            Text(placeholderInitials)
                .font(.system(.title3, design: .rounded, weight: .medium))
        }
    }
}

#Preview {
    AsyncImageCache(url: nil, placeholderInitials: "N/A") {_ in}
}
