//
//  MapController+MapPlace.swift
//  Gage
//
//  Created by Zac on 2/1/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import Foundation
import GoogleMaps

class MapPlace: NSObject
{
    var markerTitle: String?
    
    var markerSnippet: String?
    
    var location: CLLocationCoordinate2D?
    
    var zoom: Float?
    
    init(markerTitle: String, markerSnippet: String, location: CLLocationCoordinate2D, zoom: Float)
    {
        self.markerTitle = markerTitle
        self.markerSnippet = markerSnippet
        self.location = location
        self.zoom = zoom
    }
}

extension MapController
{
    func setupMap(location: CLLocationCoordinate2D, zoom: Float)
    {
        // Create a map and set it as the view
        
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: zoom)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.translatesAutoresizingMaskIntoConstraints = false
       
        self.mapView?.camera = camera
        self.mapView?.delegate = self
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.settings.myLocationButton = true
        self.mapView?.settings.compassButton = true
        self.mapView?.settings.zoomGestures = true
        self.view = mapView

        /*
        // Add constrain
        view.addSubview(mapView!)
        mapView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        mapView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 2).isActive = true **/
    }
    
    func setupMarker(location: CLLocationCoordinate2D)
    {
        // Add a marker to the map
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        marker.title = currentDestination?.markerTitle
        marker.snippet = currentDestination?.markerSnippet
        marker.map = mapView
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next",
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(jumpToNext))

    }
    
    @objc func jumpToNext()
    {
        if var index = destinations.index(where: { (mapPlace) -> Bool in
            mapPlace == currentDestination
        })
        {
            index = (index + 1) % destinations.count
            currentDestination = destinations[index]
            
            let location = CLLocationCoordinate2D(latitude: (currentDestination?.location?.latitude)!,
                                                  longitude: (currentDestination?.location?.longitude)!)
            
            let nextLocation = GMSCameraPosition.camera(withTarget: location, zoom: (currentDestination?.zoom)!)
            
            // Between begin and commit will be execute in assigned second
            let interval = 1
            CATransaction.begin()
            CATransaction.setValue(interval, forKey: kCATransactionAnimationDuration)
            mapView?.animate(to: nextLocation)
            CATransaction.commit()
            
            //            mapView?.camera = nextLocation  // no animation
        }
        
        let marker = GMSMarker(position: (currentDestination?.location)!)
        marker.title = currentDestination?.markerTitle
        marker.snippet = currentDestination?.markerSnippet
        marker.map = mapView
    }
}
