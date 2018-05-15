//
//  ListTableViewCell.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/1/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit
import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway
import Alamofire
import SwiftyJSON
import GooglePlaces
import GoogleMaps

class ListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var topListLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var milesLabel: UILabel!

//    @IBOutlet weak var cosmosView: CosmosView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addTripButtonPressed(_ sender: Any) {
    }
    

}
