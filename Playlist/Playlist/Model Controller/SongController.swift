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
    static let shared = SongController()
    
    //source of truth (S.O.T)
    var songs: [Song] = []
    
    //CRUD Methods
    //Read -wont use this for a while
    //Create
    func createSong(withTitle: String, withArtist: String) {
        //create a song and
        //add it to songs array
        songs.append(Song(title: withTitle, artist: withArtist))
        
        //save the changes
        saveToPersistenceStore()
        
    }
    
    // TODO: - Update
    //Delete
    func delete(thisSong: Song) {
        //remove a song from songs array
        guard let index = songs.firstIndex(of: thisSong) else {return}
        print(index)
        songs.remove(at: index)
        
        //save the changes
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    //fileURL create a local file url
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    //save
    func saveToPersistenceStore() {
        do {
            //encodes the songs array into json format
            let data = try JSONEncoder().encode(songs)
            //trys to write the data to a local file on the users device
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do {
            //takes the json data from the users device and load it back into an instance for the app
            let data = try Data(contentsOf: fileURL())
            //decodes the json data and loads it back into the songs array
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }

}


