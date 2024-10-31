//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetails: MovieDetails?  // Store fetched movie details
    @Published var isLoading = false  // Track loading state
    @Published var errorMessage: String?  // Track any errors

    // Fetch movie details by ID using APIClient
    func fetchMovieDetails(movieID: Int) {
        isLoading = true
        errorMessage = nil

        APIClient.shared.fetchMovieDetails(movieID: movieID) { result in
            self.isLoading = false
            switch result {
            case .success(let details):
                self.movieDetails = details
            case .failure(let error):
                self.errorMessage = "Failed to load movie details: \(error.localizedDescription)"
            }
        }
    }
}
