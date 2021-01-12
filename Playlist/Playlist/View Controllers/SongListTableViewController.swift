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
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        //loads any saved songs from the users device
        SongController.shared.loadFromPersistenceStore()
    }
    
    // MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        //this guard statement makes sure that there is something in the text fields to pass to the songcontroller object
        guard let songTitle = titleTextField.text, !songTitle.isEmpty,
              let artistName = artistTextField.text, !artistName.isEmpty else {return}
        
        SongController.shared.createSong(withTitle: songTitle , withArtist: artistName)
        
        tableView.reloadData()
        titleTextField.text = ""
        titleTextField.resignFirstResponder()
        artistTextField.text = ""
        artistTextField.resignFirstResponder()
    }
    
    // MARK: - Functions
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.shared.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        cell.textLabel?.text = SongController.shared.songs[indexPath.row].title
        cell.detailTextLabel?.text = SongController.shared.songs[indexPath.row].artist
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            SongController.shared.delete(thisSong: SongController.shared.songs[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
