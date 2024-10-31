//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

class MovieListViewModel: ObservableObject {
    @Published var actionMovies: [Movie] = []
    @Published var comedyMovies: [Movie] = []
    @Published var dramaMovies: [Movie] = []
    @Published var scifiMovies: [Movie] = []
    
    @Published var banners: [Banner] = []  // New property to store banners

    init() {
        // Fetch banners when initializing the view model
        fetchBanners()
        // Fetch movies for each genre
        fetchActionMovies()
        fetchComedyMovies()
        fetchDramaMovies()
        fetchScifiMovies()
    }

    func fetchActionMovies() {
        APIClient.shared.fetchMovies(forGenre: "action") { [weak self] movies in
            DispatchQueue.main.async {
                self?.actionMovies = movies ?? []
            }
        }
    }
    
    func fetchComedyMovies() {
        APIClient.shared.fetchMovies(forGenre: "comedy") { [weak self] movies in
            DispatchQueue.main.async {
                self?.comedyMovies = movies ?? []
            }
        }
    }

    func fetchDramaMovies() {
        APIClient.shared.fetchMovies(forGenre: "drama") { [weak self] movies in
            DispatchQueue.main.async {
                self?.dramaMovies = movies ?? []
            }
        }
    }
    
    func fetchScifiMovies() {
        APIClient.shared.fetchMovies(forGenre: "sci-fi") { [weak self] movies in
            DispatchQueue.main.async {
                self?.scifiMovies = movies ?? []
            }
        }
    }

    func fetchBanners() {
        APIClient.shared.fetchBanners { [weak self] banners in
            DispatchQueue.main.async {
                self?.banners = banners ?? []
            }
        }
    }
}
