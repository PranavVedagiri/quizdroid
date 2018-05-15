//
//  Place.swift
//  Gage
//
//  Created by Zac on 12/23/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import Foundation

class Place: NSObject
{
    // When to initialized ??????????????
    var placeId: String?
    
    var placeName: String?
    // imageName is the name of display picture
    var fileName: String?
    
    var arrivedDateString: String?
    
    var arrivedDate = Date()
    
    var leftDateString: String?
    
    var leftDate = Date()
    
    override init() { }
    // Initializer
    init(placeName: String) {
        super.init()
        self.placeName = placeName
    }
    // Initializer overload
    convenience init(placeName: String, fileName: String)
    {
        self.init(placeName: placeName)
        self.fileName = fileName
    }
    
    convenience init(placeName: String, fileName: String, arrivedDateString: String)
    {
        self.init(placeName: placeName, fileName: fileName)
        self.arrivedDateString = arrivedDateString
        self.arrivedDate = stringToDate(dateString: arrivedDateString)
    }
    
    convenience init(placeName: String, fileName: String, arrivedDateString: String, leftDateString: String)
    {
        self.init(placeName: placeName, fileName: fileName, arrivedDateString: arrivedDateString)
        self.leftDateString = leftDateString
        self.leftDate = stringToDate(dateString: leftDateString)
    }
}
