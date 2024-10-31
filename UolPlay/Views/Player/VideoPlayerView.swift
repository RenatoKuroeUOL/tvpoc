//
//  UolPlayApp.swift
//  UolPlay
//
//  Created by Renato Kuroe - UOL on 07/10/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var videoURL: URL
    @State private var player: AVPlayer?  // Create AVPlayer as a state variable

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                // Initialize AVPlayer only once
                if player == nil {
                    player = AVPlayer(url: videoURL)
                    player?.play()  // Start playing the video
                }
            }
            .onDisappear {
                // Optionally stop or pause the player when the view disappears
                player?.pause()
            }
            .edgesIgnoringSafeArea(.all)  // Make video full-screen
    }
}
