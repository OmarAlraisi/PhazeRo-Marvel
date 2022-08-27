//
//  CharacterTableViewCell.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import UIKit

protocol CharacterCellDelegate {
    func prepareSegueURL(_ url: String)
}

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterIDLabel: UILabel!
    @IBOutlet weak var wikiButtonView: UIButton!
    
    var characterCellDelegate: CharacterCellDelegate?
    var char:MarvelCharacter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell (_ ch: MarvelCharacter) {
        char = ch
        
        // This is done to have a stock image before loading rather than using the image of the previous character
        characterImageView.image = UIImage(named: "standard_fantastic")
        
        characterNameLabel.text = char.name
        characterIDLabel.text = "ID: \(String(describing: char.id))"
        
        // Only render the "WIKI" button for characters with "wiki" URLs
        if char.detailsURL == nil {
            wikiButtonView.isEnabled = false
            wikiButtonView.alpha = 0
        } else {
            wikiButtonView.isEnabled = true
            wikiButtonView.alpha = 1
        }
        
        Helpers.setImage(self.char.thumbnail, characterImageView)
    }
    
    // Follow the characterCellDelegate when the "WIKI" button is clicked
    @IBAction func characterDetailsClicked(_ sender: Any) {
        guard characterCellDelegate != nil else {
            return
        }
        characterCellDelegate!.prepareSegueURL(char!.detailsURL!)
    }
    
}
