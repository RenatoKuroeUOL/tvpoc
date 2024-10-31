//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI
import AVKit

struct MovieDetailView: View {
    let movie: Movie

    @State private var isPresentingVideoPlayer = false
    @State private var selectedVideoURL: URL?
    @State private var player: AVPlayer?
    @State private var showAlert = false
    @State private var isInWatchlist = false
    @FocusState private var focusedElement: FocusableElement?  // Use a custom enum for managing focus state

    enum FocusableElement {
        case playButton
        case watchlistButton
        case scrollView
    }

    // Example related movies for the scroll view
    @State private var actionMovies: [Movie] = [
        Movie(id: 1, title: "Action Movie 1", posterPath: "/poster1.jpg", overview: "Action Movie Overview 1"),
        Movie(id: 2, title: "Action Movie 2", posterPath: "/poster2.jpg", overview: "Action Movie Overview 2"),
        Movie(id: 3, title: "Action Movie 3", posterPath: "/poster3.jpg", overview: "Action Movie Overview 3")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Set background to black

            ScrollView { // ScrollView to make the entire page scrollable
                VStack {
                    // Movie poster
                    if let posterURL = movie.posterURL {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 300)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .padding(.top, 50)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 200, height: 300)
                                .cornerRadius(10)
                                .padding(.top, 50)
                        }
                    }

                    // Movie title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    // Buttons (Play and Watchlist)
                    HStack(spacing: 40) {
                        Button(action: {
                            // Action for the Play button
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Play")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                        }
                        .focused($focusedElement, equals: .playButton)

                        Button(action: {
                            showAlert = true
                        }) {
                            HStack {
                                Image(systemName: isInWatchlist ? "minus" : "plus")
                                Text(isInWatchlist ? "Remover dos favoritos" : "Adicionar aos favoritos")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                        }
                        .focused($focusedElement, equals: .watchlistButton)
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("UOL Play"),
                                message: Text(isInWatchlist ? "\(movie.title) foi adicionado aos favoritos." : "\(movie.title) foi removido dos favoritos."),
                                dismissButton: .default(Text("OK"), action: {
                                    isInWatchlist = !isInWatchlist
                                })
                            )
                        }
                    }
                    .padding(.horizontal)

                    // TabView with custom focus
                    TabView {
                        // First Tab: Overview Tab
                        VStack {
                            Text("Sinopse")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()

                            ScrollView {
                                Text(movie.overview)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        .background(Color.black) // Black background for tab content
                        .tabItem {
                            Label("Detalhes", systemImage: "film")
                        }

                        // Second Tab: Related Movies Tab
                        // Movie Scroll View for Action movies
                        VStack(alignment: .leading, spacing: 10) {
                            MovieScrollView(movies: $actionMovies)
                                .frame(maxWidth: .infinity, maxHeight: 220)
                                .focused($focusedElement, equals: .scrollView)  // Set focus for the scroll view
                        }
                        .padding(.bottom)  // Add some spacing at the bottom

                        .background(Color.black) // Black background for tab content
                        .tabItem {
                            Label("Títulos relacionados", systemImage: "square.grid.2x2")
                        }
                    }
                    .frame(height: 400) // Ensure the TabView is visible and scrollable
                }
                .padding(.horizontal)
            }
        }
        .onMoveCommand(perform: handleMoveCommand) // Handle keyboard or tvOS remote navigation
    }

    // Custom method to handle moving focus between elements
    private func handleMoveCommand(_ direction: MoveCommandDirection) {
        switch direction {
        case .down:
            if focusedElement == .playButton {
                focusedElement = .watchlistButton
            } else if focusedElement == .watchlistButton {
                focusedElement = .scrollView
            }
        case .up:
            if focusedElement == .scrollView {
                focusedElement = .watchlistButton
            } else if focusedElement == .watchlistButton {
                focusedElement = .playButton
            }
        default:
            break
        }
    }
}
