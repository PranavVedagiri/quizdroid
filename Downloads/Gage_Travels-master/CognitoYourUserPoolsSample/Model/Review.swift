//
//  Review.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/7/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import Foundation


struct Review {
    
   
    var rating: Int?

    var authorName: String?
    var review: String?
    var address: String?
    var description : String?
    var urlImage: String?

    
    init(authorName: String, review: String, rating: Int ) {
        self.authorName = authorName
        self.review = review
        self.rating = rating

    }
    
    
    init(address: String, rating: Int, urlImage: String, description: String) {
        self.address = address
        self.rating = rating
        self.urlImage = urlImage
        self.description = description
        
    }
}
extension Review: Equatable{}
func ==(lhs: Review, rhs: Review) -> Bool {
    return lhs.authorName == rhs.authorName
}


