//
//  TopTracksTableViewCell.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 05/04/24.
//

import UIKit

class TopTracksTableViewCell: UITableViewCell {

    @IBOutlet var topTrackImageView: UIImageView!
    
    @IBOutlet var songNameLabel: UILabel!
    
    @IBOutlet var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topTrackImageView.layer.cornerRadius = topTrackImageView.bounds.width / 2
        topTrackImageView.clipsToBounds = true

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
