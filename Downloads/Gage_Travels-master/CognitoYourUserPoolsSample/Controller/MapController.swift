//
//  MapController.swift
//  Gage
//
//  Created by Zac on 1/5/18.
//  Copyright © 2018 Zac. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire

class MapController: UIViewController, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, CLLocationManagerDelegate //UIPickerViewDelegate, UIPickerViewDataSource
{
  
    var mapView: GMSMapView?
    var markerTitle: String?
    var markerSnippet: String?
    
    var currentDestination: MapPlace?
    
    var destinations = [MapPlace]()
    
    var places = [GMSPlace]()
    // This is the key from zaclu61@gmail.com for testing
//    let googleAPIKey = "AIzaSyDwPkzdMR3sNXrqdeJ6ECgrxkwf2yuaE0o"
    let googleAPIKey = "AIzaSyCwwd_oXx1E24055EtixaZmznFX3dv-cKQ"
    
    var locationManager = CLLocationManager()
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    let startLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start Location", for: .normal)
        button.isHidden = false
        button.addTarget(self, action: #selector(openSearchLocation), for: .touchUpInside)
        return button
    }()
    
    let endLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("End Location", for: .normal)
        button.isHidden = false
        button.addTarget(self, action: #selector(openSearchLocation), for: .touchUpInside)
        return button
    }()
    
//    let showDirectionButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = UIColor.init(red: 127, green: 127, blue: 127)
//        button.setTitle("Show Location", for: .normal)
//        button.backgroundColor = UIColor.init(red: 240, green: 240, blue: 240)
//        button.isHidden = false
//        button.addTarget(self, action: #selector(showDirection), for: .touchUpInside)
//        return button
//    }()

    
    
    let whereToGo: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        tf.textColor = .black
        // Rounded corner
        tf.layer.cornerRadius = 5
        tf.layer.masksToBounds = true
        tf.leftViewMode = .always
        
        let leftPadding = 10
        let imageSize = 20
        let width = leftPadding + imageSize
        
        let iv = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: imageSize, height: imageSize))
        iv.image = UIImage(named: "gear_icon")
        iv.tintColor = .white
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: imageSize))
        
        view.addSubview(iv)
        tf.leftView = view
        tf.addTarget(self, action: #selector(thisFunc), for: .touchDown)
        return tf
    }()
    
    
    
    @objc private func thisFunc()
    {
        print("hit me")
    }
    
    private func setupWhereToGo()
    {
        view.addSubview(whereToGo)
        
        whereToGo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whereToGo.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        whereToGo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        whereToGo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/20).isActive = true
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        perform(#selector(openSearchLocation), with: nil, afterDelay: 0)
        
        
        // Backgroud thread Warning, DispatchQueue.main.async not working
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        
//        view.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        //view.backgroundColor = .white
        
        //setupNavigationBar()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        setupDestinations()
        
        
        // Catch nil
        currentDestination = self.destinations.first
        guard let location = currentDestination?.location, let zoom = currentDestination?.zoom else { return }
        
//        setupShowDirectionButton()
        
        setupMap(location: location, zoom: zoom)
        setupMarker(location: location)
        
      //  setupStackView()
//        setupEndLocationButton()
//        setupStartLocationButton()
        
//        setupWhereToGo()
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self as? GMSAutocompleteResultsViewControllerDelegate
        
       // searchController = UISearchController(searchResultsController: resultsViewController)
        //searchController?.searchResultsUpdater = resultsViewController
        
        //let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
        
        //subView.addSubview((searchController?.searchBar)!)
        //view.addSubview(subView)
        //searchController?.searchBar.sizeToFit()
        //searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
    }
    
    let placeCategories = ["Thigs to do","restaurant", "museum", "movie_theater", "aquarium", "casino", "zoo", "shopping_mall"]
    
    /*var pickerView = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return placeCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return placeCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print("The category: \(placeCategories[row])")
    }**/
    
    
    
    
    
    
    private func setupNavigationBar()
    {
//        navigationController?.navigationBar.barTintColor = .red
//        navigationController?.navigationBar.isTranslucent = false
//        // Remove the line under navigation bar
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//
//
//
////        let gearImage = UIImage(named: "gear_icon")?.withRenderingMode(.alwaysOriginal)
//        let gearBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "gear_icon"), style: .plain, target: self, action: #selector(goBackToHomeFeed))
//        // If only 1 item, use rightBarButtonItem = gearBarButton
//        navigationItem.leftBarButtonItems = [gearBarButton]
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
    }
    
    
    
    private func setupStartLocationButton()
    {
        view.addSubview(startLocationButton)
        
//        guard let mapView = mapView else { return }
        
//        startLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        startLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//        startLocationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
//        startLocationButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 20).isActive = true
    }
    
   /* private func setupStackView()
    {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let stackView = UIStackView(arrangedSubviews: [startLocationButton, pickerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        guard let mapView = mapView else { return }
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: 10).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 3).isActive = true
        
        
        
//        setupStartLocationButton()
    }**/
    
    
    
    
    
    
    private func setupEndLocationButton()
    {
        view.addSubview(endLocationButton)

//        guard let mapView = mapView else { return }

        endLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        endLocationButton.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -10).isActive = true
        endLocationButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        endLocationButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 20).isActive = true
    }
    
//    private func setupShowDirectionButton()
//    {
//        view.addSubview(showDirectionButton)
//
//        showDirectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        showDirectionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
//        showDirectionButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
//        showDirectionButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1 / 20).isActive = true
//    }
    
    @objc private func openSearchLocation()
    {
        let autoCompleteController = GMSAutocompleteViewController()

        autoCompleteController.delegate = self

        UISearchBar.appearance().tintColor = .blue

        self.locationManager.stopUpdatingLocation()

        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @objc private func showDirection()
    {
        drawPath(startLocation: destinations[0].location!, endLocation: destinations[1].location!)
    }
    
    private func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D)
    {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        let jsonUrlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        print("----------- Now draw path--------------")
        

//        Alamofire.request(jsonUrlString).responseJSON { response in
          
//            guard let response = response else { return }
            
//            let json = JSON(data: response.data!)
            
//            let routes = json["routes"].arrayValue
//
//            // print route using Polyline
//            for route in routes
//            {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let polyline = GMSPolyline.init(path: path)
//                polyline.strokeWidth = 4
//                polyline.strokeColor = UIColor.red
//                polyline.map = self.mapView
//            }
        
        
        
//        guard let url = URL(string: jsonUrlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            if (err != nil)
//            {
//                print(err as Any)
//                return
//            }
//            do
//            {
//                guard let data = data else { return }
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                print(json)
//            }
//            catch let jsonErr
//            {
//                print("Error serializing json: \(jsonErr)")
//            }
//        }.resume()
        
        
    
//        Alamofire.request(url).responseJSON { response in
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // HTTP URL response
//            print(response.data as Any)     // server data
//            print(response.result as Any)   // result of response serialization
//        }
    
        print("----------- End draw path--------------")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        
        
        
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {



        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude,
                                              longitude: place.coordinate.longitude,
                                              zoom: 16.0
        )

        // set coordinate to text

//        endLocationButton.setTitle("\(place.name)", for: .normal)
//        locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        marker.title = place.name
        marker.snippet = place.description
        marker.map = mapView


        self.mapView!.camera = camera
        self.dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupDestinations()
    {
        destinations = [MapPlace(markerTitle: "Space Needle",
                                 markerSnippet: "Seattle",
                                 location: CLLocationCoordinate2D(latitude: 47.620574, longitude: -122.349361),
                                 zoom: 16),
                        MapPlace(markerTitle: "KeyArena",
                                 markerSnippet: "Seattle",
                                 location: CLLocationCoordinate2D(latitude: 47.622362, longitude: -122.353909),
                                 zoom: 16)]
    }
}

extension MapController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = true
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
