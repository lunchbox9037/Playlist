//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by stanley phillips on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    // MARK: - Properties
    var playlist: Playlist?
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        //this guard statement makes sure that there is something in the text fields to pass to the songcontroller object
        guard let songTitle = titleTextField.text, !songTitle.isEmpty,
              let artistName = artistTextField.text, !artistName.isEmpty,
              let playlist = playlist else {return}
        
        SongController.createSong(withTitle: songTitle, withArtist: artistName, forPlaylist: playlist)

        tableView.reloadData()
        titleTextField.text = ""
        titleTextField.resignFirstResponder()
        artistTextField.text = ""
        artistTextField.resignFirstResponder()
    }
    
    // MARK: - Functions
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil coalescing opperator
        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard let song = playlist?.songs[indexPath.row] else {return cell}
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let playlist = playlist else {return}
            let songToDelete = playlist.songs[indexPath.row]
            
            SongController.delete(thisSong: songToDelete, inPlaylist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
