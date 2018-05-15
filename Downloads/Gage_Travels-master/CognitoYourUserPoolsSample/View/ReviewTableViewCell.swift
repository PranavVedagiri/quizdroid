//
//  LocationTableViewCell.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/1/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit
class ReviewTableViewCell: UITableViewCell {
    
    
    
//    @IBOutlet weak var cosmosView: CosmosView!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var reviewSummaryText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
