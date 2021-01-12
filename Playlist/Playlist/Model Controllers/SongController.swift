//
//  SongController.swift
//  Playlist
//
//  Created by stanley phillips on 1/11/21.
//

import Foundation

class SongController {
    
    //shared instance
    //makes the controller dynamic and able to take in information from the user instead of hard coding data
    //dont need it anymore
    
    //CRUD Methods
    //Read -wont use this for a while
    //Create
    static func createSong(withTitle: String, withArtist: String, forPlaylist: Playlist) {
        forPlaylist.songs.append(Song(title: withTitle, artist: withArtist))
        
        //save the changes
        PlaylistController.shared.saveToPersistenceStore()
    }
    
    //Delete
    static func delete(thisSong: Song, inPlaylist: Playlist) {
        //remove a song from songs array
        //guard let index = songs.firstIndex(of: thisSong) else {return}
        //print(index)
        //songs.remove(at: index)
        guard let songToDelete = inPlaylist.songs.firstIndex(of: thisSong) else {return}
        inPlaylist.songs.remove(at: songToDelete)
        
        //save the changes
        PlaylistController.shared.saveToPersistenceStore()
    }
}


