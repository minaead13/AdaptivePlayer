//
//  HLSPlayerViewModel.swift
//  AdaptivePlayer
//
//  Created by OSX on 22/04/2025.
//

import UIKit
import AVFoundation

class HLSPlayerViewModel: ObservableObject {
    @Published var isHighQuality = true
    @Published var currentAudioTrack: String = "Stereo"
    
    var streamURL: URL {
        let devicePrefix = UIDevice.current.userInterfaceIdiom == .pad ? "video_ipad" : "video_iphone"
        let qualitySuffix = isHighQuality ? "" : "_low"
        let urlString = "https://hls-streams-stage.s3.eu-central-1.amazonaws.com/out_streams_video_crop_test_from_stream_1/stream_1/streams/\(devicePrefix)\(qualitySuffix)/stream.m3u8"
        return URL(string: urlString)!
    }
    
    var audioURL: URL {
           let audioStream = currentAudioTrack == "Stereo" ? "stereo" : "spatial"
           let urlString = "https://hls-streams-stage.s3.eu-central-1.amazonaws.com/out_streams_video_crop_test_from_stream_1/stream_1/streams/\(audioStream)/stream.m3u8"
           return URL(string: urlString)!
       }
    
    var toggleButtonText: String {
        isHighQuality ? "Switch to Low Quality" : "Switch to High Quality"
    }
    
    var toggleAudioTrackText: String {
        currentAudioTrack == "Stereo" ? "Switch to Spatial Audio" : "Switch to Stereo Audio"
    }
    
    func toggleQuality() {
        isHighQuality.toggle()
    }
    
    func toggleAudioTrack() {
        currentAudioTrack = (currentAudioTrack == "Stereo") ? "Spatial" : "Stereo"
    }
    
   
}

