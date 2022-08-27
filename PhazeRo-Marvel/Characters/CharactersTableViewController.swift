//
//  TableViewController.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 22/08/2022.
//

import UIKit

class CharactersTableViewController: UITableViewController, CharactersModelDelegate, CharacterCellDelegate{
    
    
    var charactersModel = CharactersModel()
    var characters = [MarvelCharacter]()
    
    // This is used to store the wiki url if a character has one
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        charactersModel.charactersDelegate = self
        charactersModel.loadCharacters()
    }
    
    // This is the delgator for the characters model for when the characters are fetched
    func charactersFetched(_ characters: [MarvelCharacter]) {
        self.characters.append(contentsOf: characters)
        /*
            Note: The reason we are appending rather than setting the value of characters is
                  because more characters can be loaded while scrolling, and we don't want
                  to lose the previous data.
        */
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
            Note: The character view has two segues, one leads to the comics when clicking on
                  a table cell, and the other leads to a web view when clicking on the "WIKI"
                  button if the character has one. So, we need to check which segue this is.
        */
        if segue.identifier == "webSegue" {
            let vc = segue.destination as! WebViewViewController
            vc.url = targetURL
            return
        }
        
        // Check that a cell is sellected
        guard tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        let vc = segue.destination as! ComicsViewController
        vc.char = characters[tableView.indexPathForSelectedRow!.row]
    }
    
    // This is the delegator for the "WIKI" button
    func prepareSegueURL(_ url: String) {
        targetURL = url
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell

        cell.configureCell(self.characters[indexPath.row])
        cell.characterCellDelegate = self
        
        // Load more characters if there are only 10 characters left
        if Helpers.offset + 100 - indexPath.row <= 10 {
            charactersModel.loadCharacters()
        }

        return cell
    }
}
