//
//  ListViewController.swift
//
//
//  Created by Pranav Vedagiri on 4/21/18.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway
import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import GooglePlaces
import GoogleMaps

class ListViewController: UIViewController{
    
    
    @IBOutlet weak var imageView: UIImageView!
    //    @IBOutlet var countryImageView: UIImageView!
    @IBOutlet var TableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var rankAddedLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    typealias JSONDictionary = [String:Any]
     let cellSpacingHeight: CGFloat = 5
    
    var responseArray = [JSONDictionary]()
    var places  = [ListPlaces]()
    var interest = [InterestPlaces]()
    var newTrip = [ListPlaces]()
    var swagger = UserDetailTableViewController()
    var interestSearch = ""
    var isSearching = false
    var copyLinks = [String]()
    var placeId = ""
    var indexPlace = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey(Constants.GoogleAPI.GoogleAPIKey)
        GMSPlacesClient.provideAPIKey(Constants.GoogleAPI.GoogleAPIKey)
//        loadImage(url: Constants.URL.SearchTextURL + searchText)
        
        self.cityNameLabel.text = searchText

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         getPlacesData()
//        self.cityNameLabel.text = places[0].topRank
    }
    
    
    
    
    

    
    
    func searchTerms(searchBar: UISearchBar, searchText:String)      {
        self.interestSearch  = searchText.capitalized
    }
    
    
    func getLocationData()  {
        //create session and request
        let session = URLSession.shared
        let request = URLRequest(url:URL(string: Constants.URL.searchInterestTextURl + "\(searchText)?type=" + interestSearch )!)
        print("request for Location \(request)")
        
        let task = session.dataTask(with: request){(data, response, error) in
            
            /*GUARD: Was there an error?*/
            guard( error == nil) else {
                
                print("There was an error with your reques: \(String(describing: error?.localizedDescription))")
                return
            }
            
            /*GUARD: Did we get a successful 2xx response?*/
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx! : \(String(describing: error?.localizedDescription))")
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else{
                print(" No data was returned by the request!: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let parsedResult: [String:AnyObject]!
            
            
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                
                
            }catch{
                print("Could not parse the data as JSON: \(data)")
                return
            }
            
            //Get the PlacesCache Array
            guard let result = parsedResult["PlacesCache"] as? NSArray else{
                print("Could not find PlaceCache")
                return
            }
//            print("Location Data \(result)")
            
            //Loop through the result and add them to places
            for i in 0..<result.count {
                
                self.interest.append(InterestPlaces(
                    imageURL: ((result[i] as AnyObject).value(forKey: "S3Link") as? String)!,
                    rank: (result[i] as AnyObject).value(forKey: "Rating") as! Double,
                    placeId: (result[i] as AnyObject).value(forKey: "PlaceId") as! String,
                    topRank: (result[i] as AnyObject).value(forKey: "PlaceName") as! String))
                
                
                
            }
            //Reload the data on the main thread
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
            
            
        }
        task.resume()
    }
    
    
    //Get data from the AWS API
    func getPlacesData()  {
        //create session and request
        let session = URLSession.shared
        let request = URLRequest(url:URL(string: Constants.URL.SearchPlacesTextURL + searchText)!)
        print("request \(request)")
        
        let task = session.dataTask(with: request){(data, response, error) in
            
            /*GUARD: Was there an error?*/
            guard( error == nil) else {
                
                print("There was an error with your reques: \(String(describing: error?.localizedDescription))")
                return
            }
            
            /*GUARD: Did we get a successful 2xx response?*/
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx! : \(String(describing: error?.localizedDescription))")
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else{
                print(" No data was returned by the request!: \(String(describing: error?.localizedDescription))")
                return
            }
            
            let parsedResult: [String:AnyObject]!
            
            
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                
                
            }catch{
                print("Could not parse the data as JSON: \(data)")
                return
            }
            //Get the PlacesCache Array
            guard let result = parsedResult["PlacesCache"] as? NSArray else{
                print("Could not find PlaceCache")
                return
            }
          
            // Get a random image form the links
            self.loadImage(url: (result[Int(arc4random_uniform(UInt32(6)))] as AnyObject).value(forKey: "S3Link") as! String)

            //Loop through the result and add them to places
            for i in 0..<result.count {
        
                self.places.append(ListPlaces(
                    imageURL: ((result[i] as AnyObject).value(forKey: "S3Link") as? String)!,
                    rank: (result[i] as AnyObject).value(forKey: "Rating") as! Double,
                    placeId: (result[i] as AnyObject).value(forKey: "PlaceId") as! String,
                    topRank: (result[i] as AnyObject).value(forKey: "PlaceName") as! String))
                
                

            }
            //Reload the data on the main thread
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }


        }
        task.resume()
    }

    
    //Display the image on the main page
    func loadImage(url:String)  {
        let imageURL = URL(string: url)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                let downloadImage = UIImage(data: data!)
                DispatchQueue.main.async{
   
                    self.imageView.image = downloadImage
                    
                }

            }
            
        }
        task.resume()
        
    }
    
    @IBAction func switchMapViewButtonPressed(_ sender: Any) {

    }
    
    
    @IBAction func organizePlanButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "showItinerary", sender: self)
        
    }
    
    @IBAction func optionButtonPressed(_ sender: Any) {
    }
    
    @IBAction func moreOptionButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func addTripButtonPressed(_ sender: Any) {
        
        showAlert()
        addPlacList()
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "showSort", sender: self)
    }
    
    @IBAction func seeTripOptionButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "showTrip", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showItinerary" {
            if segue.destination is OrganizePlanViewController {
                
                print("Itineary View")
            }
        }
//
        if segue.identifier == "showReview" {
            
            if let vc = segue.destination as? ReviewViewController {
                print("vcplaceID \(vc.placeId) and \(placeId)")
                print("urlImage \(String(describing: places[self.indexPlace].imageURL))")
                vc.placeId = placeId
                vc.urlImage = places[self.indexPlace].imageURL
                vc.rating = places[self.indexPlace].rank
                vc.namePlace = places[self.indexPlace].topRank!
                
                
                
            }

        }
        
        if segue.identifier == "showInterest" {
            if let vc = segue.destination as? InterestViewController {
                print("Pace interestSearch \(self.interestSearch)")
                vc.interestSearch = self.interestSearch
            }
        }
        
        if segue.identifier == "showSort" {
            let vc = segue.destination
            if let nv = vc.popoverPresentationController {
                nv.delegate = self as? UIPopoverPresentationControllerDelegate
            }
        }
        
//        GAGETripPlannerApiClient.itinerariesPost(GAGETripPlannerApiClient.)
//        func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
//            return .none
//        }
        
        
        
    }
    
    
    
    func addPlacList()  {
        
       
        
        let place = places[self.indexPlace]
        
        self.newTrip.append(place)
        print("addNewTrip = \(self.newTrip))")

      

    }
    
    
    func showAlert()  {
        let alert = UIAlertController(title: "Add Trip to Trip", message: "Choose a list to add your Trip to  ", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "New Trip", style: UIAlertActionStyle.default, handler: { action in
            
            print("Add New Trip")
            
        }))
        
        alert.addAction(UIAlertAction(title: "Created Itineraries", style: UIAlertActionStyle.default, handler: { (action) in
            print("created Trip")
        }))
       
        self.present(alert, animated: true, completion: nil)
        
    }
    

    
}

extension ListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.interestSearch = searchBar.text!

         performSegue(withIdentifier: "showInterest", sender: self)
    }
}



extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return places.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let place = places[indexPath.row]
        self.placeId = place.placeId!
        self.indexPlace = indexPath.row
        performSegue(withIdentifier: "showReview", sender: self)
        
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = TableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! ListTableViewCell
        
        
        let place = places[indexPath.row]
       
//        print("cellPlaceId \(self.placeId) original \(place.placeId)")
        
//        let newTrip = NewTrip(imageURL: place.imageURL!, rank: place.rank!, placeId: place.placeId!, topRank: place.topRank!)
//
//        addPlacList(indexPath: newTrip)
//
        
        
        cell.rankLabel.text = String(format: "%.2f", place.rank!)
        cell.topListLabel.text = "#\(indexPath.row) - \(String(describing: place.topRank!))"

//        cell.cosmosView.rating = place.rank!
        
        
        cell.layer.borderWidth = 5
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1).cgColor

        let imageURL = URL(string: place.imageURL!)
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            
            if error == nil {
                
                let downloadImage = UIImage(data: data!)

                DispatchQueue.main.async{
                    cell.imageViewCell.image = downloadImage
                }
                
            }
            
        }
        task.resume()

        
        return cell
        
    }
    
    
    
    
}



