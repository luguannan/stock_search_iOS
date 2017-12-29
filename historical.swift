//
//  Historical.swift
//  stockMarketSearch
//
//  Created by Guannan Lu on 11/29/17.
//  Copyright © 2017 Guannan Lu. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON


class Historical: UIViewController, UIWebViewDelegate {
  var stockSymbol: String = ""
    
    @IBOutlet weak var historical: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myPath = Bundle.main.path(forResource: "historical", ofType: "html")
        print(stockSymbol)
        historical.loadRequest(NSURLRequest(url: NSURL(string: myPath!)! as URL) as URLRequest)
        historical.isOpaque = false

        // Do any additional setup after loading the view.
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(stockSymbol)
        let ht = "$(function(){plotChart(\"" + stockSymbol + "\");});"
        historical.stringByEvaluatingJavaScript(from:ht)
        print(stockSymbol)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
