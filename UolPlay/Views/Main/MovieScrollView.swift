//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct MovieScrollView: View {
    @Binding var movies: [Movie]
    @FocusState var focusedIndex: Int?  // Pass focus state from parent view
    @State private var selectedMovie: Movie?  // State to hold the selected movie
    
    // Define the layout for the horizontal grid (one row, flexible spacing)
    let gridItems = [
        GridItem(.fixed(250), spacing: 10)  // Fixed size for each item, with spacing
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridItems, spacing: 10) {  // Use LazyHGrid for horizontal layout
                ForEach(movies.indices, id: \.self) { index in
                    MovieThumbnailView(movie: movies[index], isFocusedIndex: focusedIndex == index)
                        .frame(width: 150, height: 250)  // Set fixed size for thumbnails
                        .focusable()  // Make the item focusable
                        .focused($focusedIndex, equals: index)  // Bind focus state to index
                        .padding(.leading, index == 0 ? 20 : 0)  // Padding for first item
                        .padding(.trailing, index == movies.count - 1 ? 20 : 0)  // Padding for last item
                        .onTapGesture {
                            selectedMovie = movies[index]  // Set selected movie when tapped
                        }
                }
            }
        }
        .fullScreenCover(item: $selectedMovie) { movie in
            MovieDetailView(movie: movie)  // Navigate to detail view on selection
        }
    }
}
