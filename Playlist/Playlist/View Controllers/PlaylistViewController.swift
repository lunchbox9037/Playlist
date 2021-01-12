//
//  PlaylistViewController.swift
//  Playlist
//
//  Created by stanley phillips on 1/12/21.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Outlets
    @IBOutlet weak var playlistTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createPlaylistButtonTapped(_ sender: Any) {
        guard let title = playlistTextField.text, !title.isEmpty else {return}
        PlaylistController.shared.createPlaylistWith(title: title)
        playlistTableView.reloadData()
        playlistTextField.text = ""
    }
    
    // MARK: - Tableview Data Source Functions
    //define the amount of rows needed for the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    //populate cells in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        cell.textLabel?.text = PlaylistController.shared.playlists[indexPath.row].title
        cell.detailTextLabel?.text = "\(PlaylistController.shared.playlists[indexPath.row].songs.count) songs"
        print(PlaylistController.shared.playlists[indexPath.row].songs.count)
        
        return cell
    }
    
    //delete rows in table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            PlaylistController.shared.delete(thisPlaylist: PlaylistController.shared.playlists[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IDENTIFIER: make sure the segue identifiers match
        if segue.identifier == "toSongList" {
            //INDEX: get the index for the selected playlist
            guard let i = playlistTableView.indexPathForSelectedRow,
                  //DESTINATION: make sure the destination is the SongListTableViewController
                  let destination = segue.destination as? SongListTableViewController else {return}
            //Object to send
            let playlistToSend = PlaylistController.shared.playlists[i.row]
            //Object to receive
            destination.playlist = playlistToSend
        }
    }
}

