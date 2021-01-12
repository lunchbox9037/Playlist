//
//  Song.swift
//  Playlist
//
//  Created by stanley phillips on 1/11/21.
//

import Foundation

//song also needs to be encodable to save persistence data
class Song: Codable {
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

//makes the song object equatable to compare values
extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
}

// lhs            rhs
//[song1...10]     song7
//checks to see if the values match on each value in the array with the rhs
