//
//  NewTrip.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/6/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import Foundation


struct NewTrip  {
    var imageURL : String?
    var rank: Double?
    var placeId: String?
    var topRank: String?
    
    
    
    init(imageURL:String, rank: Double, placeId: String, topRank:String) {
        
        
        self.imageURL = imageURL
        self.rank = rank
        self.placeId = placeId
        self.topRank = topRank
    }

}
