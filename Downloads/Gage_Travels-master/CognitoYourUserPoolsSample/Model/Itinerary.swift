//
//  Itinery.swift
//  Gage
//
//  Created by Zac on 12/25/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import Foundation

class Itinerary: NSObject
{
    // When to initialize ??????????????
    var itineraryId: String?
    
    var users = [User]()
    // Avoid user id duplication
    var userSet = Set<String>()
    
    var places = [Place]()
    // Avoid place id duplication
    var placeSet = Set<String>()
    
    var collaborated = false
    
    override init() { }
    
    /// A user start itinerary
    ///
    /// - Parameter user:
    init(user: User)
    {
        super.init()
        self.addUser(user: user)
    }
    
    convenience init(user: User, place: Place)
    {
        self.init(user: user)
        self.places.append(place)
        guard let placeId = place.placeId else { return }
        self.placeSet.insert(placeId)
    }
    
    init(users: [User])
    {
        super.init()
        for user in users { addUser(user: user) }
    }
    
    convenience init(users: [User], places: [Place])
    {
        self.init(users: users)
        for place in places { addPlace(place: place) }
    }
    
    /// Add user to itinerary
    ///
    /// - Parameter user:
    func addUser(user: User)
    {
        guard let userId = user.userId else { return }
        
        if !self.userSet.contains(userId)
        {
            self.users.append(user)
            self.userSet.insert(userId)
        }
        // Make this shared intinery
        if self.users.count > 1
        {
            self.collaborated = true
        }
    }
    
    /// Add place to itinerary
    ///
    /// - Parameter place:
    func addPlace(place: Place)
    {
        guard let placeId = place.placeId else { return }
        
        if !self.placeSet.contains(placeId)
        {
            self.places.append(place)
            self.placeSet.insert(placeId)
        }
    }
    
    /// Set intierary to collaborated
    func setCollaboratedItinerary()
    {
        self.collaborated = true
    }
    
    /// Set itinerary to private
    func setPrivateItinerary()
    {
        self.collaborated = false
    }
    
    /// Check if itinerary is collaborated
    ///
    /// - Returns:
    func checkCollaborated() -> Bool
    {
        return collaborated
    }
    
    /// Delete trip
    func deleteTrip()
    {
        places.removeAll()
        users.removeAll()
        placeSet.removeAll()
        userSet.removeAll()
        self.collaborated = false
    }
    
    func endTrip()
    {
        // check if in process  ?????????
        
        
        
        
        deleteTrip()
    }
}
