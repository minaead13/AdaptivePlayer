//
//  ContentView.swift
//  AdaptivePlayer
//
//  Created by OSX on 22/04/2025.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @StateObject private var viewModel = HLSPlayerViewModel()
    @State private var videoPlayer: AVPlayer = AVPlayer()
    @State private var audioPlayer: AVPlayer = AVPlayer()
    
    var body: some View {
        VStack {
            PlayerView(player: videoPlayer)
                .frame(height: 300)
                .onAppear {
                    loadStream()
                }
            
            Button(action: {
                viewModel.toggleQuality()
                loadStream()
            }) {
                Text(viewModel.toggleButtonText)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Button(action: {
                viewModel.toggleAudioTrack()
            }) {
                HStack {
                    Text(viewModel.toggleAudioTrackText)
                    Spacer()
                    Text("Active: \(viewModel.currentAudioTrack)")
                        .foregroundColor(.gray)
                        .italic()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.2))
                .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
    
    private func loadStream() {
        let item = AVPlayerItem(url: viewModel.streamURL)
        videoPlayer.replaceCurrentItem(with: item)
        videoPlayer.play()
        
        
        let item2 = AVPlayerItem(url: viewModel.audioURL)
        audioPlayer.replaceCurrentItem(with: item2)
        audioPlayer.play()
    }

}

struct PlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = true
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

#Preview {
    ContentView()
}
