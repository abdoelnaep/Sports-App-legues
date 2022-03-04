//
//  favTableViewCell.swift
//  SportsApp
//
//  Created by Abdullah on 03/03/2022.
//

import UIKit

class favTableViewCell: UITableViewCell {
    let url: NSURL? = nil
    var gotoYoutube: (() -> ())?
    
    @IBOutlet var favTableViewImage: UIImageView!
    
    @IBOutlet var favTableViewILabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favTableViewIYoutubePressed(_ sender: Any) {
        gotoYoutube!()
    }
}
