//
//  ViewController.swift
//  Gage
//
//  Created by Zac on 12/21/17.
//  Copyright © 2017 Zac. All rights reserved.
//

import UIKit
import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource //UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    // places array to display itinerary
    var places: [Place] = []
    // MenuBar
    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()
    

    
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        // Setups
        setupPlaces()
        //setupNavigationBar()
        //setupSearchBar()

        // Setup background
        collectionView?.backgroundColor = UIColor(red: 200, green: 200, blue: 200)
        // Setup CollectionView
        collectionView?.register(PlaceCell.self, forCellWithReuseIdentifier: "placeId")
        // Push CollectionView donw 40 pixels(MenuBar is 40 pixels)
//        collectionView?.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

        // Avoid going underneath MenuBar when scrolling collectionView
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(40, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

        // Jump to check login status first
        perform(#selector(checkLoginStatus), with: nil, afterDelay: 0)
    }
    
//    @objc func openLocation()
//    {
//        let autoCompleteController = GMSAutocompleteViewController()
//        
//        autoCompleteController.delegate = self
//        
//        UISearchBar.appearance().tintColor = .blue
//        
//        self.locationManager.stopUpdatingLocation()
//        
//        self.present(autoCompleteController, animated: true, completion: nil)
//    }
    

    
//    @objc private func searchPlace()
//    {
//        let navigationController = UINavigationController.init(rootViewController: MapController())
//        self.present(navigationController, animated: true, completion: nil)
//    }
    
    /// Load place info from backend
    private func setupPlaces()
    {
        // Fake data, fetch from backend later
        let fileNames = ["Seattle", "Tacoma", "Portland"]
        let placeNames = ["Seattle, WA", "Tacoma, WA", "Portland, OR"]
        let arrivedDates = ["June 1 2018", "June 1 2017", "June 1 2016"]
        let leftDates = ["June 3 2018", "June 4 2017", "June 5 2016"]
        
        for (index, _) in placeNames.enumerated()
        {
            let place = Place(placeName: placeNames[index],
                              fileName: fileNames[index],
                              arrivedDateString: arrivedDates[index],
                              leftDateString: leftDates[index])
            
            places.append(place)
        }
    }
    
    /// Check user login status
    @objc private func checkLoginStatus()
    {
        self.present(SignInViewController(), animated: true, completion: nil)
    }
    
    /// Setup MenuBar to HomeController
    /// This will be implemented along with map search later
    private func setupMenuBar()
    {
        view.addSubview(menuBar)
        view.addConstrainWithFormat(format: "H:|[v0]|", views: menuBar)
        // MenuBar high is 1/10 frame height, no bottom constrain
        view.addConstrainWithFormat(format: "V:|[v0(\(view.frame.height / 10))]", views: menuBar)
    }
    

    
    /// Display account info
    @objc private func displayAccountInfo()
    {
        let navController = UINavigationController(rootViewController: AccountController())
        self.present(navController, animated: true, completion: nil)
    }
    
    /// Setup itineray cell number
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - section:
    /// - Returns:
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return places.count
    }
    
    /// Setup image for each collectionView block
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - indexPath:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeId", for: indexPath) as! PlaceCell
        let place = places[indexPath.item]
        // Catch nil pointer exceptions
        guard let imagePropertyName = place.fileName,
              let placePropertyName = place.placeName,
              let arrivedDateString = place.arrivedDateString,
              let leftDateString = place.leftDateString
        else { return cell }
        
        let imageName: String = imagePropertyName
        let placeName: String = placePropertyName
        let placeDate: String = arrivedDateString + "-" + leftDateString
        let placeInfo: String = placeName + "\n" + placeDate
        let placeImage = UIImage(named: imageName)
        
        guard let thumbnailImage = placeImage else { return cell }
        // Attach dates on image
        let tempImage: UIImage = textToImage(text: placeInfo, image: thumbnailImage,
                                             point: CGPoint(x: thumbnailImage.size.width * 1 / 20,
                                                            y: thumbnailImage.size.height * 3 / 4),
                                                            fontName: "Helvetica",
                                                            fontSize: (thumbnailImage.size.height) / 15)
        cell.thumbnailImageView.image = tempImage
//        cell.tintColor = UIColor.rgbWtihAlphaOne(red: 90, green: 10, blue: 10)
        return cell
    }
    
    /// Assign cell size
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - collectionViewLayout:
    ///   - indexPath:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        // left and right has 10 pixels gap from boundries, in setupPlaceCell()
        // images are 16:9(1080p, 720p)
        let height = (width - 10 - 10) * 9 / 16
        return CGSize(width: width, height: height)
    }

    /// Setup 0 space between 2 collecitonView (thumbnailImageView)
    ///
    /// - Parameters:
    ///   - collectionView:
    ///   - collectionViewLayout:
    ///   - section:
    /// - Returns:
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        self.user?.signOut()
        self.title = nil
        self.response = nil
        //self.tableView.reloadData()
        self.refresh()
    }
    
    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
                self.title = self.user?.username
                //self.tableView.reloadData()
            })
            return nil
        }
    }
}
