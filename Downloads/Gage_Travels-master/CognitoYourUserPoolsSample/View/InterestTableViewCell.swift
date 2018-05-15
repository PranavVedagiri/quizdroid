//
//  InterestTableViewCell.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/6/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit

class InterestTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewCell: UIImageView!
    
//    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
