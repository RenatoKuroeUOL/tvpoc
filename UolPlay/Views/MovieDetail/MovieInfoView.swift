//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI

struct MovieInfoView: View {
    let details: MovieDetails

    var body: some View {
        HStack(spacing: 10) {
            // Release Date (formatted to Brazilian style)
            if let releaseDate = details.releaseDate {
                Text(formatDateToBrazilianStyle(releaseDate: releaseDate))
            }

            // Add dot separator
            if details.releaseDate != nil && (details.runtime != nil || details.genres != nil) {
                Text("•")
            }

            // Runtime
            if let runtime = details.runtime {
                Text("\(runtime) min")
            }

            // Add dot separator
            if details.runtime != nil && details.genres != nil {
                Text("•")
            }

            // Genres
            if let genres = details.genres {
                Text(genres.map { $0.name }.joined(separator: ", "))
            }
        }
        .foregroundColor(.white)
        .font(.subheadline)
        .lineLimit(1)
        .truncationMode(.tail)
    }

    // Helper function to format date
    func formatDateToBrazilianStyle(releaseDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"  // Assume API gives date in this format
        if let date = inputFormatter.date(from: releaseDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"  // Brazilian format
            return outputFormatter.string(from: date)
        }
        return releaseDate  // Fallback to original if parsing fails
    }
}
