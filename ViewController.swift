//
//  ViewController.swift
//  FinalProjectSarai
//
//  Created by Lovjot Sarai on 4/28/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var SplitViewCC:Cusine = Cusine()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBreakfast: UILabel!
    @IBOutlet weak var labelLunch: UILabel!
    @IBOutlet weak var lblSnack: UILabel!
    @IBOutlet weak var lblDinner: UILabel!
    @IBOutlet weak var lblDessert: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var progressbar: UIView!
    @IBOutlet weak var lblSpicy: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lightBeige = UIColor(red: 245/255, green: 245/255, blue: 220/255, alpha: 1.0)
        view.backgroundColor = lightBeige
        lblBreakfast.text = SplitViewCC.breakfastItem
        lblName.text = SplitViewCC.name + " Cuisine"
        lblBreakfast.text = SplitViewCC.breakfastItem
        lblSnack.text = SplitViewCC.snackItem
        lblDinner.text = SplitViewCC.dinnerItem
        lblDessert.text = SplitViewCC.dessertItem
        labelLunch.text = SplitViewCC.lunchItem
        lblDescription.text = SplitViewCC.description
        
        var map:UIImage = convertToImage(urlString: SplitViewCC.mapURL)
        ImageView.image = map
        ImageView.layer.cornerRadius = 30
        ImageView.clipsToBounds = true
        ImageView.layer.borderWidth = 5
        ImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        ImageView.layer.cornerRadius = 10
        ImageView.clipsToBounds = true
        lblDescription.layer.cornerRadius = 25
        lblDescription.layer.borderWidth = 2
        lblDescription.layer.borderColor = UIColor.lightGray.cgColor
        progressbar.layer.borderWidth = 5
        progressbar.layer.cornerRadius = 10
        progressbar.layer.borderColor = UIColor.black.cgColor
        progressbar.backgroundColor = UIColor.red
        updateProgressBar(valueString: SplitViewCC.spiceLevel)


    }
    
    
    

    
    @IBAction func Button(_ sender: Any) {
        openMapsAppWithSearchTerm(SplitViewCC.name)
    }
    
    func updateProgressBar(valueString: String) {
        guard let value = Int(valueString) else {
            print("Error: Invalid input value")
            return
        }
        
        let maxWidth = view.bounds.width - 32 // 16pt padding on each side
        let percentage = CGFloat(value) / 10.0
        let newWidth = maxWidth * percentage
        
        lblSpicy.text = "Fetching Spice Levels"
        
        UIView.animate(withDuration: 2.0, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.progressbar.frame.size.width = newWidth
        }) { (completed) in
            self.lblSpicy.text = "Spice Found " + " Level " + self.SplitViewCC.spiceLevel
            UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseInOut], animations: {
                self.progressbar.frame.size.width = 0
            }) { (completed) in
                UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseInOut], animations: {
                    self.progressbar.frame.size.width = newWidth
                })
            }
        }
    }




    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! webviewController
        destinationController.passedCusine = SplitViewCC
    }
    
    
    
    
    
    
    func openMapsAppWithSearchTerm(_ searchTerm: String) {
        let encodedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedSearchString = "Restaurant near me".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedString = "\(encodedSearchTerm)+\(encodedSearchString)"
        let directionsRequest = "http://maps.apple.com/?q=\(encodedString)"
        let url = URL(string: directionsRequest)!
        UIApplication.shared.open(url)
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
        //return the UIImage
        return img!
    }

    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.view.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 200/255, alpha: 0)
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration: 2.0, animations: {
            self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        })
        
    }
    
    
    
}

