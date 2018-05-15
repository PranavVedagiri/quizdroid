//
//  User.swift
//  Gage
//
//  Created by Zac on 12/26/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import Foundation

class User: NSObject
{
    // When get initialized ?????????
    var userId: String?
    
    var userName: String?
    
    var email: String?
    
    var firstName: String?
    
    var lastName: String?
    
    var phoneNumber: String?
    
    var userProfileImage: String?
    
    override init() { }
    
    init(userName: String, email: String)
    {
        super.init()
        self.userName = userName
        self.email = email
    }
    
    convenience init(userName: String, email: String, firstName: String)
    {
        self.init(userName: userName, email: email)
        self.firstName = firstName
    }
    
    convenience init(userName: String, email: String, firstName: String, lastName: String)
    {
        self.init(userName: userName, email: email, firstName: firstName)
        self.lastName = lastName
    }
    
    convenience init(userName: String, email: String, firstName: String, lastName: String, phoneNumber: String)
    {
        self.init(userName: userName, email: email, firstName: firstName, lastName: lastName)
        self.phoneNumber = phoneNumber
    }
    
    convenience init(userName: String, email: String, firstName: String, lastName: String,
                     phoneNumber: String, userImage: String)
    {
        self.init(userName: userName, email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        self.userProfileImage = userImage
    }
}
