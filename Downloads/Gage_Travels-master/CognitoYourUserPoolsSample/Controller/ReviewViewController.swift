//
//  LocationView.swift
//  CognitoYourUserPoolsSample
//
//  Created by Pranav Vedagiri on 4/22/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import Foundation
import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway
import UIKit
import Alamofire
import SwiftyJSON
import GooglePlaces
import GoogleMaps

import AWSAuthCore

public var add = [String]()

class ReviewViewController: UIViewController  {

    

//    @IBOutlet weak var cosmosView: CosmosView!
    
   
    @IBOutlet weak var littleCosmosView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openHoursLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var TablewView: UITableView!
    var urlImage : String?
    var placeId = ""
    var imageURL = ""
    var address = ""
    var time = ""
    var rating  : Double?
    var namePlace = ""
    
    
    
    var reviewArray = [Review]()
    var placeReviewArray = [Review]()
    var descArray = [String]()
    var indexPath : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
//        callAPI()
//        cosmosView.didFinishTouchingCosmos = mySaveFunction
//        getLocationData()
//        print("placeID \(placeId)")
//        populateFrontPage()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocationData()
    }
    func mySaveFunction(rating: Double){
//        cosmosView
    }
    
    
    func populateFrontPage()  {
        
        DispatchQueue.main.async {
            
            
            self.descriptionTextView.text = self.placeReviewArray[0].description
            self.addressLabel.text = self.placeReviewArray[0].address
            self.ratingLabel.text = "\(String(describing: self.rating!))"
            self.loadImage(url: self.urlImage!)
            self.nameLabel.text = self.namePlace
            
        }
        
       
        loadImage(url: self.placeReviewArray[0].urlImage!)
        
        
        
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
    func getLocationData()  {
        //create session and request
        let session = URLSession.shared
        let request = URLRequest(url:URL(string: Constants.URL.searchPlaceTextURL + placeId)!)
        print("request Location \(request)")
        
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
            
            print("parsedResult \(parsedResult)")
            //Get the PlacesCache Array
            guard let reviews = parsedResult["Reviews"] as? NSArray else{
                print("Could not find Reviews")
                return
            }
            
            
            print("Reviews \(reviews)")
            
            
            guard let description = parsedResult["Description"] as? String else{
                print("Could not find Description")
                return
            }
        
            guard let address = parsedResult["Address"] as? String else{
                print("Could not find Address")
                return
            }
//            guard let rating = parsedResult["Rating"] as? Int else {
//                print("Could not find Rating Font page")
//                return
//            }
            
            guard let urlImage = parsedResult["S3Link"] as? String else {
                print("Could not find s3Link")
                return
            }
            
            
            self.placeReviewArray.append(Review(address: address, rating: Int(45.5), urlImage: urlImage, description: description))

            guard let OpeningHours = parsedResult["OpeningHours"] as? NSArray else{
                print("Could not find OpeningHours")
                return
            }
            
            
            
            for i in 0..<reviews.count{

                
                self.reviewArray.append(Review(
                    authorName: ((reviews[i] as AnyObject).value(forKey: "AuthorName") as? String)!,
                    review: ((reviews[i] as AnyObject).value(forKey: "Text") as? String)!, rating: ((reviews[i] as AnyObject).value(forKey: "Rating") as? Int)!))
                

                
            }
            self.populateFrontPage()
            print("placeReview \(self.placeReviewArray)")
            print("Append Review \(self.reviewArray)")
            
            
            DispatchQueue.main.async {
                self.TablewView.reloadData()
            }

        }
        task.resume()
    }
    

    
    @IBAction func addDreamListButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addTripButtonPressed(_ sender: Any) {
    }
    
    
}
extension  ReviewViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(("reviewscount \(reviewArray.count)"))
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let review = reviewArray[indexPath.row]
//        self.address = review.
        
//        print(<#T##items: Any...##Any#>)
        print("reviewCell[] \(review)")
        self.indexPath = indexPath.row
        let cell = TablewView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        
        
        cell.reviewSummaryText.text = review.review!
        cell.userNameLabel.text = review.authorName!
//        cell.cosmosView.rating = Double(review.rating!)
//        cell.dateLabel.text = review.
//        review.
//        cell.starsImageView.
        
        
        
        return cell
        
    }
    
    
    
}
