//
//  webviewController.swift
//  FinalProjectSarai
//
//  Created by Lovjot Sarai on 4/28/23.
//

import Foundation
import WebKit

class webviewController : UIViewController {
    
    @IBOutlet var webview: UIView!
    
    
    @IBOutlet weak var wbView: WKWebView!
    @IBOutlet weak var testing: UILabel!
    
    var passedCusine = Cusine()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var site = passedCusine.wikiURL
        let siteURL = (URL(string: site))
        let request = URLRequest(url: siteURL!)
        wbView.load(request)
        
        
    }
   
    
}
