//
//  VideosView.swift
//  MoviesApp
//
//  Created by SAMBIT DASH on 28/10/19.
//  Copyright © 2019 SAMBIT DASH. All rights reserved.
//

import SwiftUI
import AVKit

struct VideosView: View {
    var videos: [MovieVideo]
    
    var body: some View {
        List {
            PlayerView(urlString: videos.first?.videoKey ?? "")
            .frame(height: 250)
        }
        .padding(.horizontal, -16)
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
        VideosView(videos: [MovieVideo(id: 0, videoKey: "https://www.youtube.com/watch?v=Gy_3Q241QNE", videoName: "", videoSite: "YouTube", videoType: "")])
    }
}

struct PlayerView: UIViewControllerRepresentable {
    private(set) var url: URL
    
    init?(urlString: String) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=\(urlString)") else { return nil }
        self.url = url
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player: AVPlayer = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        return playerController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}
