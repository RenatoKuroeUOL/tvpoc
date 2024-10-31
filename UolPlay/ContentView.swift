//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieListViewModel()

    @FocusState private var focusedScrollView: Int?  // Track which scroll view is focused

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Full-width banner section at the top
                BannerView(banners: $viewModel.banners)
                    .frame(height: 600)
                    .zIndex(1)

                // Action genre section (first scroll view to focus)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ação")
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(.white)

                    MovieScrollView(movies: $viewModel.actionMovies)
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .focused($focusedScrollView, equals: 1)
                }

                // Comedy genre section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Comédia")
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(.white)

                    MovieScrollView(movies: $viewModel.comedyMovies)
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .focused($focusedScrollView, equals: 2)
                }

                // Drama genre section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Drama")
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(.white)

                    MovieScrollView(movies: $viewModel.dramaMovies)
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .focused($focusedScrollView, equals: 3)
                }

                // Sci-Fi genre section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ficção Científica")
                        .font(.headline)
                        .padding(.leading)
                        .foregroundColor(.white)

                    MovieScrollView(movies: $viewModel.scifiMovies)
                        .frame(maxWidth: .infinity, maxHeight: 220)
                        .focused($focusedScrollView, equals: 4)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            focusedScrollView = 1  // Focus the first scroll view
        }
        .edgesIgnoringSafeArea(.horizontal)
        .background(Color.black)
        .ignoresSafeArea(edges: [.top, .horizontal])
    }
}
