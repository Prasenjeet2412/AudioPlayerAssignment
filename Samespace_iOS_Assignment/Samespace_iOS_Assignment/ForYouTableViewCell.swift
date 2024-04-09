//
//  ForYouTableViewCell.swift
//  Samespace_iOS_Assignment
//
//  Created by Prasenjeet Pandagale on 05/04/24.
//

import UIKit

class ForYouTableViewCell: UITableViewCell {

    @IBOutlet var forYouImageView: UIImageView!
    
    @IBOutlet var songLabel: UILabel!
    
    @IBOutlet var artistLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        forYouImageView.layer.cornerRadius = forYouImageView.bounds.width / 2
        forYouImageView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
