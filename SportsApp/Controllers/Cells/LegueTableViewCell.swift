//
//  LegueTableViewCell.swift
//  SportsApp
//
//  Created by Abdullah on 28/02/2022.
//

import UIKit

class LegueTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    let url: NSURL? = nil
    var gotoYoutube: (() -> ())?
    
    @IBOutlet var legueImage: UIImageView!
    
    @IBOutlet var legueName: UILabel!
    
    @IBAction func youtubeBressed(_ sender: Any) {
        gotoYoutube!()
    }
}
