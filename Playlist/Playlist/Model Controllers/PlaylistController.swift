//
//  PlaylistController.swift
//  Playlist
//
//  Created by stanley phillips on 1/12/21.
//

import Foundation

class PlaylistController {
    // MARK: - Properties
    //create a shared instance of the Playlist controller to be accessed throughout the program
    static let shared = PlaylistController()
    
    //new source of truth
    var playlists: [Playlist] = []
    
    // MARK: - CRUD functions
    //create
    func createPlaylistWith(title: String) {
        playlists.append(Playlist(title: title))
        //save
        saveToPersistenceStore()
    }
    
    //delete
    func delete(thisPlaylist: Playlist) {
        guard let index = playlists.firstIndex(of: thisPlaylist) else {return}
        playlists.remove(at: index)
        //save
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
            //encodes the object array into json format
            let data = try JSONEncoder().encode(playlists)
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
            //takes the json data from the users device and load it back into an instance for the app to use
            let data = try Data(contentsOf: fileURL())
            //decodes the json data and loads it back into the object array
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
