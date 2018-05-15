//
// Copyright 2014-2018 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import AWSCognitoIdentityProvider
import AWSAPIGateway
import UIKit
import Alamofire
import SwiftyJSON
import GooglePlaces
import GoogleMaps
import AWSCore

//import AlamofireObjectMapper

public var links = [String]()
public var names = [String]()
public var placeids = [String]()
public var ratings = [Int]()

public var swag = [[String]()]

public var searchText = String()

class UserDetailTableViewController : UIViewController , UISearchBarDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var response: AWSCognitoIdentityUserGetDetailsResponse?
    var user: AWSCognitoIdentityUser?
    var pool: AWSCognitoIdentityUserPool?
    var list: [String] = [String]()
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var txt = ""
    @IBOutlet var imageURL: UIImageView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("userName \(String(describing: UserDefaults.standard.string(forKey: "userName")))")
//        if  (UserDefaults.standard.string(forKey: "userName") != nil){
//            print()
//        }
        //self.tableView.delegate = self
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        if (self.user == nil) {
            self.user = self.pool?.currentUser()
        }
        self.refresh()
        searchBar.delegate = self
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: CognitoIdentityUserPoolRegion,
                                                                identityPoolId: CognitoIdentityUserPoolId)
        let configuration = AWSServiceConfiguration(region: CognitoIdentityUserPoolRegion,
                                                    credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        print(credentialsProvider.identityId)
        
    }
    
    func loadFirstPhotoForPlace(placeID: String, insertImage: UIImageView!) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto, insertImage: insertImage)
                    
                    print("FirstPhoto \(firstPhoto)")
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata, insertImage: UIImageView) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                insertImage.image = photo;
            }
        })
    }
    
    var placeid = ""
    func searchBar(searchBar: UISearchBar, searchText: String) {
        txt = searchText.capitalized
    }
    
    


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //print("searchText \(searchBar.text)")
       /* let URL = "https://jw81psa4qk.execute-api.us-west-2.amazonaws.com/testing/places-search-cache/" + searchBar.text!
        Alamofire.request(URL, method: .get).responseJSON { response in
            let swiftyJsonVar = JSON(response.result.value!)
            stuff = response.result.value as! NSDictionary
            //print(swiftyJsonVar)
            if(swiftyJsonVar != JSON.null){
                //print(swiftyJsonVar["RegionPlaceId"])
                //print(response.result.value)
                for (key, subJson) in swiftyJsonVar["PlacesCache"] {
                    var title: String? = subJson["S3Link"].string
                    //print(title)
                    if (title != nil) && !(title!.isEmpty){
                        links.append(title!)
                        names.append(subJson["PlaceName"].string!)
                        placeids.append(subJson["PlaceId"].string!)
                        ratings.append(subJson["Rating"].int!)
                    }else{
                        links.append(subJson["PlaceId"].string!)
                        names.append(subJson["PlaceName"].string!)
                        placeids.append(subJson["PlaceId"].string!)
                        ratings.append(subJson["Rating"].int!)
                    }
                }
            }
        }**/
        searchText = searchBar.text!
        performSegue(withIdentifier: "listView", sender: self)
    }
    
    func returnSearchText(text: String){
        
    }
    
    func completionHandler(value: String?){
        print(value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListViewController{
            
        }
    }
    
    func returnLinks(links: [String]){
        swag.append(links)
    }
    
    func returnNames(names: [String]) -> [String]{
        return names
    }
    
    func returnPlaceID(placeID: [String]) -> [String]{
        return placeID
    }
    
    func returnRatings(ratings: [String]) -> [String]{
        return ratings
    }
    
    func populateHome(placeid: String, link: String, moreplaces: String){
        //for element in placeids {
       //     print(element)
        //}
//        loadFirstPhotoForPlace(placeID: placeid, insertImage: imageview)
        
        if let url = URL(string: link) {
            if let data = NSData(contentsOf: url) {
                imageURL.image = UIImage(data: data as Data)
            }
        }
//        loadFirstPhotoForPlace(placeID: moreplaces, insertImage: thirdImage)
    }
    
    @IBAction func signOUtButtonPressed(_ sender: Any) {
                self.user?.signOut()
                self.title = nil
                self.response = nil
                //self.tableView.reloadData()
                self.refresh()
        
    }
    
    
    @IBAction func mapButtonPressed(_ sender: Any) {
    }
    
    
    //    @IBAction func signOut(_ sender: AnyObject) {
//        self.user?.signOut()
//        self.title = nil
//        self.response = nil
//        //self.tableView.reloadData()
//        self.refresh()
//    }
    
    

    func refresh() {
        self.user?.getDetails().continueOnSuccessWith { (task) -> AnyObject? in
            DispatchQueue.main.async(execute: {
                self.response = task.result
//                self.title = self.user?.username
                //self.tableView.reloadData()
            })
            return nil
        }
    }

}



