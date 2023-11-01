//
//  CusineListController.swift
//  FinalProjectSarai
//
//  Created by Lovjot Sarai on 4/28/23.
//

import Foundation
import UIKit
import ImageIO
import MobileCoreServices


class CusineListController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let lightBeige = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        view.backgroundColor = lightBeige
        GetJSONData()
    }
    
    
    @IBOutlet weak var gifView: UIImageView!
 

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // the Segue knows the destination controller.
        var destController = segue.destination as! ViewController
        // find the selected row index from the tableview
        let index = tableView.indexPathForSelectedRow
        // find the matching row in the object array
        let selectedRowHT = CusineObjectArray[index!.row]
        // set the destinaiton controller Hiking Trail object with the object from the selected tableView row.
        destController.SplitViewCC = selectedRowHT
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CusineObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // remind me to add an IDentifier for this cell on the storyboard.
        let lightBeige = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        var myCell = tableView.dequeueReusableCell(withIdentifier: "myCellID")
        var cellIndex = indexPath.row
        var CC = CusineObjectArray[cellIndex]
        myCell!.textLabel!.text = CC.name
        myCell!.detailTextLabel!.text = CC.description
        var img:UIImage = convertToImage(urlString: CC.imageURL)
        myCell!.imageView?.image = img
        myCell!.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        myCell!.imageView?.frame.size.width = 200
        myCell!.imageView?.frame.size.height = 200
        myCell!.imageView?.layer.cornerRadius =  25
        myCell!.imageView?.clipsToBounds = true
        myCell!.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        myCell!.imageView?.layer.borderColor = UIColor.darkGray.cgColor
        myCell!.imageView?.layer.borderWidth = 2
        myCell!.textLabel!.textColor = UIColor.red
        myCell!.backgroundColor = lightBeige
        return myCell!
    }
    

    func convertToImage(urlString: String) -> UIImage {
        // Reach out to the URL and download bytes of data.
        //convert string to a URL type
        let imgURL = URL(string:urlString)!
        //2. call the end point and receive the Bytes
        let imgData  = try? Data(contentsOf: imgURL)
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        //convert bytes of data to image type
        let img = UIImage(data: imgData!)
        let originalImage = UIImage(data: imgData!)
        let newSize = CGSize(width: 125, height: 85)
        let resizedImage = resizeImage(image: originalImage!, newSize: newSize)

        
        //return the UIImage
        return resizedImage
    }
    
    var CusineObjectArray = [Cusine]()
    
    
    
    
    func resizeImage(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    
    func GetJSONData() {
        
        // Use the String address and convert it to a URL type
        let endPointString  = "https://raw.githubusercontent.com/LovjotSarai/IT315FinalProject/main/cuisineData.json"
        let endPointURL = URL(string: endPointString)
        
        // Pass it to the Data function
        
        let dataBytes = try? Data(contentsOf:endPointURL!)
        // Receive the bytes
        print(dataBytes) // just for developers to see what is received. this will help in debugging
        
        
        if (dataBytes != nil) {
            // get the JSON Objects and convert it to a Dictionary
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: dataBytes!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print("Dictionary --:  \(dictionary) ---- \n") // for debugging purposes
            
            // Split the Dictionary into two parts. Keep the HikingTrails Part and discard the other
            let CCDictionary = dictionary["cuisines"]! as! [[String:AnyObject]]
            
            
            for index in 0...CCDictionary.count - 1  {
                // Dictionary to Single Object (Hiking Trail)
                let singleCC = CCDictionary[index]
                // create the Hiking Trail Object
                let CC = Cusine()
                //reterive each object from the dictionary
                CC.name = singleCC["name"] as! String
                CC.description = singleCC["description"] as! String
                CC.breakfastItem = singleCC["breakfast"] as! String
                CC.lunchItem = singleCC["lunch"] as! String
                CC.dinnerItem = singleCC["dinner"] as! String
                CC.dessertItem = singleCC["dessert"] as! String
                CC.snackItem = singleCC["snack"] as! String
                CC.imageURL = singleCC["imageURL"] as!String
                CC.mapURL = singleCC["flagURL"] as!String
                CC.wikiURL = singleCC["wikiURL"] as!String
                CC.spiceLevel = singleCC["spicelevel"] as!String
                CusineObjectArray.append(CC)
            }
            
            
        }
    }
    
    
    
    
    
}
    
    
