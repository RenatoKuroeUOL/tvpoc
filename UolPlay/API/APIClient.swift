//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    private let apiKey = "1108ad0c4d7a751b72c7dc3bcdc3cdc9"
    
    func fetchBanners(completion: @escaping ([Banner]?) -> Void) {
            let urlString = "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)"
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                // Print raw data for debugging
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print("Raw JSON response: \(json)")  // Print the raw JSON
                    }
                }

                guard let data = data else {
                    completion(nil)
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let bannerResponse = try decoder.decode(BannerResponse.self, from: data)
                    completion(bannerResponse.results)
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                    completion(nil)
                }
            }.resume()
        }
    
    // Fetch movies for a specific genre
    func fetchMovies(forGenre genre: String, completion: @escaping ([Movie]?) -> Void) {
        let genreId = getGenreId(for: genre) // Get the genre ID based on the genre string
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&with_genres=\(genreId)&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching movies: \(String(describing: error))")
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                completion(movieResponse.results)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // Function to fetch movie details by ID
       func fetchMovieDetails(movieID: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
           let urlString = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)"
           guard let url = URL(string: urlString) else {
               completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
               return
           }

           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
                   return
               }

               guard let data = data else {
                   DispatchQueue.main.async {
                       completion(.failure(NSError(domain: "No data", code: 404, userInfo: nil)))
                   }
                   return
               }

               do {
                   let decodedResponse = try JSONDecoder().decode(MovieDetails.self, from: data)
                   DispatchQueue.main.async {
                       completion(.success(decodedResponse))
                   }
               } catch {
                   DispatchQueue.main.async {
                       completion(.failure(error))
                   }
               }
           }.resume()
       }
    
    // Function to map genre names to TheMovieDB genre IDs
    private func getGenreId(for genre: String) -> String {
        switch genre.lowercased() {
        case "action":
            return "28"
        case "comedy":
            return "35"
        case "drama":
            return "18"
        case "sci-fi":
            return "878"
        default:
            return "0" 
        }
    }
}





