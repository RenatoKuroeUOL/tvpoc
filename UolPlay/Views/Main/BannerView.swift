//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct BannerView: View {
    @Binding var banners: [Banner]
    
    @FocusState private var focusedBanner: Int?
    @State private var selectectedBanner: Banner?

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(banners.indices, id: \.self) { index in
                        let banner = banners[index]
                        
                        // Pass title and description from the banner
                        BannerThumbnailView(
                            banner: banner,
                            title: banner.title ?? "Sem título",
                            overview: banner.overview ?? ""
                        )
                        .frame(width: geometry.size.width)  // Full width for each banner
                        .focusable()
                        .focused($focusedBanner, equals: index)
                        .onTapGesture {
                            selectectedBanner = banners[index]  // Set selected movie when tapped
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 600)
        .edgesIgnoringSafeArea(.horizontal)  // Ensure full-width horizontally
        .fullScreenCover(item: $selectectedBanner) { banner in
            MovieDetailView(movie:
                                Movie(
                                    id: banner.id,
                                    title: banner.title ?? "",
                                    posterPath: banner.backdropPath,
                                    overview: banner.overview ?? ""))  // Navigate to detail view on selection
        }
    }
}
