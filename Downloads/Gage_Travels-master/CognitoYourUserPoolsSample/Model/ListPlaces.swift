//
//  ListPlaces.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/2/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import Foundation

class ListPlaces {
    
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
extension ListPlaces: Equatable{}
func ==(lhs: ListPlaces, rhs: ListPlaces) -> Bool {
    return lhs.placeId == rhs.placeId
}

