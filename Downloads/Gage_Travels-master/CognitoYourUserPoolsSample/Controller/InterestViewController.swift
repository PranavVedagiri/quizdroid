//
//  InterestViewController.swift
//  CognitoYourUserPoolsSample
//
//  Created by Martin Chibwe on 5/6/18.
//  Copyright © 2018 Dubal, Rohan. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController {
    
    var interestSearch = ""
    var interest = [InterestPlaces]()
    var review = [Review]()
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("interestSearch \(interestSearch)")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getLocationData()
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
            print("Location Data \(result)")
            
            //Loop through the result and add them to places
            for i in 0..<result.count {
                //check back 
                self.interest.append(InterestPlaces(
                    imageURL: (result[i] as AnyObject).value(forKey: "S3Link") as! String,
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

}
extension InterestViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InterestTableViewCell
        
        
        let place = interest[indexPath.row]
        
        
     
        
        
        
//        cell.rankLabel.text = String(format: "%.2f", place.rank!)
//        cell.topListLabel.text = "#\(indexPath.row) - \(String(describing: place.topRank!))"
        
//        cell.cosmosView.rating = place.rank!
        
//        cell.
        cell.rankingLabel.text = "\(String(describing: place.rank!))"
        cell.placeNameLabel.text = place.topRank!
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


