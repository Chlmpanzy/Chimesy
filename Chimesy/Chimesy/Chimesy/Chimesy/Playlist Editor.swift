//
//  Playlist Editor.swift
//  Chimesy
//
//  Created by Swift Admin on 2023-12-13.
//

import Foundation
import AVFoundation

var allPlaylists: [String:Playlist] = [:]
var allSongs =  [String:Song]() 
func newPlaylist(name: String) -> Bool {
    if allPlaylists[name] == nil {
        allPlaylists[name] = Playlist(name: name)
        return true
    }
    return false
}

func newSong(name: String, songFile: URL, length: Int) -> Bool {
    if allSongs[name] == nil{
        allSongs[name] = Song(name: name, songFile: songFile, length: length)
        return true
    }
    return false
}

func addSong(song: Song, playlist: inout Playlist){
    playlist.songs.append(song)
    
}

func removeSong(song: Song, playlist: inout Playlist){
    if let indexToRemove = playlist.songs.firstIndex(of: song){
        playlist.songs.remove(at: indexToRemove)
    }
}

struct Song: Equatable{
    var name: String
    var songFile: URL?
    var length: Int
    static func ==(lhs: Song, rhs: Song) -> Bool {
        if let lhsFile = lhs.songFile, let rhsFile = rhs.songFile {
            return lhsFile == rhsFile
        }
        return false
    }
}

struct Playlist{
    var name: String
    var songs: [Song] = []
    var length: Int{
        songs.reduce(0) { $0 + $1.length }
    }
}
