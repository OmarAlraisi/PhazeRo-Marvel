//
//  ComicTableViewCell.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import UIKit

protocol ComicCellDelegate {
    func prepareSegueURL(_ url: String)
}

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var comicTitleLabel: UILabel!
    
    var delegate: ComicCellDelegate?
    var comic: Comic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell (_ com: Comic) {
        comic = com
        comicTitleLabel.text = comic.title
    }

    // Follow the ComicCellDelegate when the "MORE" button is clicked
    @IBAction func moreDetailsClicked(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        delegate!.prepareSegueURL(comic!.detailsURL)
    }
}
