//
//  Features.swift
//  Chimesy
//
//  Created by Swift Admin on 2023-12-13.
//

import Foundation
import AVFoundation

//sleep
class Features: YourAudioPlayerClass{
    func sleep() {
        let seconds = sleephours * 3600 // 1 hour = 3600 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
            // This code will be executed after the specified time
            self.audioPlayer.pause()
        }
    }
    
    //searching
    // Search for playlists
    func playlistSearch(prompt: String) -> [Playlist] {
        return allPlaylists.keys.filter { $0.localizedStandardContains(prompt) }.compactMap { allPlaylists[$0] }
    }
    
    // Search for songs
    func songSearch(prompt: String) -> [Song] {
        return allSongs.keys.filter { $0.localizedStandardContains(prompt) }.compactMap { allSongs[$0] }
    }
    
    
    //Skip
    func skip(){
        if currentPlaylistIndex < currentPlaylist.count{
            currentPlaylistIndex += 1
            playNext()
        } else{
            audioPlayer.stop()
        }
    }
    
    //Rewind
    func rewind() {
        let currentTime = audioPlayer.currentTime
        // Check if more than 2 seconds have passed in the current song
        if currentTime > 2.0 || currentPlaylistIndex == 0{
            audioPlayer.currentTime = 0
        } else {
            currentPlaylistIndex -= 1
        }
        playNext()
    }
    
    //Loop
    func looping(_ bool: Bool){
        //this will be used in the play next function
        loop = bool
    }
    //Shuffle
    func shuffling(_ bool: Bool){
        //this will be used as a paramter for player
        shuffle = bool
    }
    
    //Pausing and resuming
        
}

