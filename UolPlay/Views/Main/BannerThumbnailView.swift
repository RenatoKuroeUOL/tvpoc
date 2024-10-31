//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct BannerThumbnailView: View {
    let banner: Banner
    let title: String
    let overview: String

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                // Left side with text occupying 50% of the width
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                    
                    Text(overview)
                        .font(.body)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .padding(.leading, 60)  // Add some padding on the left
                .frame(width: UIScreen.main.bounds.width * 0.5, alignment: .leading)  // Text takes 50% width

                // Right side with image occupying 50% of the width
                if let imageURL = banner.imageURL {
                    ZStack {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()  // Ensure the image fill the frame
                                .frame(width: UIScreen.main.bounds.width * 0.5, height: 600)  // Image take 50% width
                                .clipped()  // Clip the image to avoid overflow
                        } placeholder: {
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: UIScreen.main.bounds.width * 0.5, height: 600)
                        }

                        // Gradient overlay from black to transparent
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(1.0), Color.black.opacity(0.4), Color.clear]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: 600)  // Cover the image with a gradient
                    }
                } else {
                    // Placeholder for null image
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: 600)
                        .overlay(Text("No Image").foregroundColor(.white))
                }
            }
            .frame(height: 600)  // Set the total height of the banner
        }
    }
}
