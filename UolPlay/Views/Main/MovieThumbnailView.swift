//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct MovieThumbnailView: View {
    let movie: Movie
    var isFocusedIndex: Bool  // Track focus state from parent

    var body: some View {
        VStack {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image.resizable()
                         .scaledToFit()
                         .frame(width: 150, height: 225)  // Fixed size for both focused and non-focused states
                         .cornerRadius(10)  // Add corner radius to the image
                         .overlay(  // Apply yellow border with corner radius on focus
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isFocusedIndex ? Color.yellow : Color.clear, lineWidth: 5)
                         )
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 150, height: 225)
                        .cornerRadius(10)  // Add corner radius to the placeholder
                        .overlay(  // Apply yellow border with corner radius on focus
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isFocusedIndex ? Color.yellow : Color.clear, lineWidth: 5)
                        )
                }
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 225)
                    .cornerRadius(10)  // Add corner radius to the "No Image" rectangle
                    .overlay(
                        Text("No Image")
                            .foregroundColor(.white)
                            .font(.caption)
                    )
                    .overlay(  // Apply yellow border with corner radius on focus
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isFocusedIndex ? Color.yellow : Color.clear, lineWidth: 5)
                    )
            }
        }
        .padding(10)
        .animation(.easeInOut(duration: 0.4), value: isFocusedIndex)  // Animate the border on focus change
    }
}


