//
//  CharacterViewController.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 22/08/2022.
//

import UIKit

class ComicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComicsModelDelegate, ComicCellDelegate {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var comicsTableView: UITableView!
    
    var char: MarvelCharacter!
    
    var comics = [Comic]()
    var comicsModel = ComicsModel()
    
    // This is used to store the "MORE" url for the webView segue
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsModel.delegate = self
        comicsModel.getComics(char.id)
        
        comicsTableView.delegate = self
        comicsTableView.dataSource = self
    }
    
    // Since this view controller has only one segue, there is no need to check the identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewViewController
        vc.url = targetURL
    }
    
    // This is the delegator for the "MORE" button
    func prepareSegueURL(_ url: String) {
        targetURL = url
    }
    
    override func viewWillAppear(_ animated: Bool) {
        characterNameLabel.text = char.name
        Helpers.setImage(char.thumbnail, characterImageView)
    }
    
    // This is the delegator for comics model
    // It is highly unlikely to have a character with over 100 comics, so we only fetch once
    func comicsFetched(_ comics: [Comic]) {
        self.comics = comics
        self.comicsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicCell", for: indexPath) as! ComicTableViewCell
        
        cell.configureCell(comics[indexPath.row])
        cell.delegate = self
        
        return cell
    }
}
