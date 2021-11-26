//
//  ExploreTableViewCell.swift
//  semana7
//
//  Created by MAC07 on 23/11/21.
//

import UIKit
import SkeletonView

class ExploreTableViewCell: UITableViewCell {

    @IBOutlet weak var exploreImage: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCountRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exploreImage.layer.cornerRadius = 12
        exploreImage.layer.masksToBounds = true
        exploreImage.isSkeletonable = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
