//
//  InterestPlaces.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/7/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import Foundation


struct InterestPlaces {
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
extension InterestPlaces: Equatable{}
func ==(lhs: InterestPlaces, rhs: InterestPlaces) -> Bool {
    return lhs.placeId == rhs.placeId
}
