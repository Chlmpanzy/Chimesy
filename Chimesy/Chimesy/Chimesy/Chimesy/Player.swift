//
//  Player.swift
//  Chimesy
//
//  Created by Swift Admin on 2023-11-28.
//
/// Notes:
///I need to update my player so that it updates when somethign is added to queue cause right now it scans once then just goes off that. Maybe I  use a recursion to recheck queue every time instead of a for loop (Done)
///While recursion did solve tht probelm, it now prevents me from acsessing the previous songs in the playlist in case i wanted to rewing back, so I'll use an index to keep my place in the playlist, rather then delete the song from the currentPLaylist
import Foundation
import AVFoundation
var queue: [Song] = []
func done(){
    print("done")
}

class YourAudioPlayerClass: NSObject, AVAudioPlayerDelegate{
    var audioPlayer = AVAudioPlayer()
    var currentPlaylist: [Song] = []
    var currentPlaylistIndex: Int = 0
    var loop = false
    var shuffle = true
    var sleephours = 3 //default setting
    var singleURL:URL? = nil
    var x = 1
    var isLooping = false
    

    //This is the final list of songs we'll use to run the play function with
    func resumeOrPause(_ bool: Bool){
        switch bool {
        case true:
            audioPlayer.pause()
            pausing = false
        case false:
            audioPlayer.play()
            pausing = true
        }
    }

    func getPlaying(chosenPlaylist: Playlist, shuffle: Bool){
        var playlistQueue = playing(currentPlaylist: chosenPlaylist).getPlaylist(shuffle: shuffle)
        play(playlist: playlistQueue)
    }
    // thsis is going to be used to get what order the playlist will be played in
    struct playing{
        var currentPlaylist: Playlist?
        mutating func playPlaylist(playlist: Playlist) {
            currentPlaylist = playlist
        }
        func getPlaylist(shuffle: Bool) -> [Song] {
            guard let playlist = currentPlaylist else {
                return []
            }
            if shuffle {
                return playlist.songs.shuffled()
            }
            return playlist.songs
        }
    }
    //editing the queue
        //remove
    func removeFromQueue(from songs: inout [Song], what song: Song) {
        if let indexToRemove = songs.firstIndex(of: song) {
            songs.remove(at: indexToRemove)
        }
    }
        //add
    func addToQueue(song: Song){
        queue.append(song)
    }
    //final play function, plays the music when play button pressed

    func play(playlist: [Song]) {
        currentPlaylist = playlist
        currentPlaylistIndex = 0
        playNext()
    }
    func check(){
        //if loop == true && currentPlaylist.count-currentPlaylistIndex<10{
            //looping logic
        //}
        // Check if there are songs in the queue
        if !queue.isEmpty, let url = queue[0].songFile {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                queue.remove(at: 0)
                playNext() // Automatically play the next song after playing from the queue
                return
            } catch {
                print("Error playing audio from queue: \(error.localizedDescription)")
            }
        }
    }
    func playsingle(url: URL){
        check()
        do {
            // Assign the URL before playing
            singleURL = url

            // Stop any existing player
            audioPlayer.stop()

            // Create a new audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = true ? -1 : 0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            // Update the loop flag
            isLooping = loop
        } catch let error as NSError{
            print("Error playing audio from playlist: \(error.localizedDescription)")
        }
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        done()
        if isLooping {
                playsingle(url: singleURL!)
            }
    }

    func playNext() {
        //checking for loop
        check()

        // Check if there are songs in the current playlist
        if currentPlaylistIndex < currentPlaylist.count, let url = currentPlaylist[currentPlaylistIndex].songFile {
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                currentPlaylistIndex += 1 // Move to the next song in the playlist
                playNext() // Automatically play the next song in the playlist
            } catch {
                print("Error playing audio from playlist: \(error.localizedDescription)")
            }
        }
    }
}
