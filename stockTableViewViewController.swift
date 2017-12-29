//
//  stockTableViewViewController.swift
//  stockMarketSearch
//
//  Created by Guannan Lu on 11/29/17.
//  Copyright © 2017 Guannan Lu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData


class stockTableViewViewController: UIViewController, UITableViewDelegate, UITableViewdataSource, UIWebViewDelegate, UIPickerViewDelegate, UIPickerViewdataSource  {
    var htmls: String?
    var path: String?
    var indi: String?
    var a:Array = ["Price","SMA","EMA","STOCH","RSI", "MACD","STOCH","ADX"]


    @IBOutlet weak var drawgrah: UIPickerView!
    
    @IBOutlet weak var scrolltable: UIScrollView!
    @IBOutlet weak var stockDetailTable: UITableView!

    @IBOutlet weak var graph: UIWebView!
    var Tabledata : Array<Dictionary<String, String>> = Array<Dictionary<String, String>>()
    var stockDetail: Dictionary<String, String> = Dictionary<String, String>()
    var stockSymbol: String?
    
    @IBOutlet weak var star: UIButton!
    
    var DateTime: Array<Any> = []
    var dataArray: Array<Any> = []
    var dataArrayV: Array<Any> = []
    var change : Double = 0.0
    
    override func viewWillLayoutSubviews() {//set the scrollviews area
        scrolltable.frame = self.view.bounds
        scrolltable.contentSize.height = 800
        scrolltable.contentSize.width = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return stockDetail.count-2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = stockDetailTable.dequeueReusableCell(withIdentifier: "stockRow", for: indexPath) as! stockTableViewCell
        switch indexPath.row{
        case 0:
            cell.stockSymbol.text = "Stock Symbol"
            cell.stockValue.text = Tabledata[0]["symbol"]
        case 1:
            cell.stockSymbol.text = "Last Price"
            cell.stockValue.text = Tabledata[0]["price"]
        case 2:
            cell.stockSymbol.text = "Change"
            cell.stockValue.text = Tabledata[0]["change"]
            if (change > 0) {
                cell.UpDown.image = UIImage(named: "green.png")
            } else {
                cell.UpDown.image = UIImage(named: "red.png")
            }
        case 3:
            cell.stockSymbol.text = "Timestamp"
            cell.stockValue.text = Tabledata[0]["timestamp"]
        case 4:
            cell.stockSymbol.text = "Open"
            cell.stockValue.text = Tabledata[0]["open"]
        case 5:
            cell.stockSymbol.text = "Close"
            cell.stockValue.text = Tabledata[0]["close"]
        case 6:
            cell.stockSymbol.text = "Day's Range"
            cell.stockValue.text = Tabledata[0]["range"]
        case 7:
            cell.stockSymbol.text = "Volume"
            cell.stockValue.text = Tabledata[0]["volume"]
        default:
            cell.textLabel?.text = "Key"
            
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTable()
        path = Bundle.main.path(forResource: "price", ofType: "html")
        print("qaz")
        graph.loadRequest(NSURLRequest(url: NSURL(string: path!)! as URL) as URLRequest)
        graph.isOpaque = false
        htmls = "$(function(){drawPrice(\"" + stockSymbol! + "\");});"
        // Do any additional setup after loading the view.
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        graph.stringByEvaluatingJavahtmls(from: htmls!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTable() {
        Alamofire.request("http://nodejs-env1.us-west-1.elasticbeanstalk.com/stock.json",parameters:["input":stockSymbol!]).responseSwiftyJSON { response in
            let data = response.result.value //A JSON object
            let isSuccess = response.result.isSuccess
            if (isSuccess && (data != nil)) {
                let time = data!["Time Series (Daily)"]
                let current = time["2017-11-30"]
                self.stockDetail["price"] = current["4. close"].string!
                self.stockDetail["symbol"] = data!["Meta data"]["2. Symbol"].string!
                let previous = time["2017-11-29"]
                print("wsx")
                let change = round(Double(current["4. close"].string!)! - Double(previous["4. close"].string!)!) * 100 / 100
                let changep = round((change / Double(previous["4. close"].string!)!) * 10000) / 100
                self.stockDetail["changeOris"] = String(change)
                self.stockDetail["changep"] = String(changep)
                print("qqd")
                self.stockDetail["change"] = String(change) + "(" + String(changep) + "%)"
                self.stockDetail["timestamp"] = data!["Meta data"]["3. Last Refreshed"].string!
                self.stockDetail["open"] = String(round(Double(current["1. open"].string!)! * 100) / 100)
                self.stockDetail["close"] = String(round(Double(current["4. close"].string!)! * 100) / 100)
                self.stockDetail["range"] = String(round(Double(current["1. open"].string!)! * 100) / 100) + "-" + String(round(Double(current["4. close"].string!)! * 100) / 100)
                self.stockDetail["volume"] = current["5. volume"].string!
                print(self.stockDetail.count)
                self.Tabledata.append(self.stockDetail)
                let time_series = time.sorted(by: {$0 > $1})
                
                self.stockDetailTable.reloaddata()
                
                var i = 0
                for item in time_series {
                    let itemkey = item.0
                    print(itemkey)
                    print("rr")
                    self.DateTime.append(itemkey)
                    self.dataArray.append(data!["Time Series (Daily)"][String(itemkey)]["1. open"])
                    self.dataArrayV.append(data!["Time Series (Daily)"][String(itemkey)]["5. volume"])
                    i = i + 1
                }
            }
        }
    }
    
   @IBAction func addFav() {
    let app = UIApplication.shared.delegate as! AppDelegate
    let context = app.persistentContainer.viewContext


        if star.imageView?.image == UIImage(named: "empty.png"){
            print("ssed")
            let newitem = NSEntityDehtmlsion.insertNewObject(forEntityName: "Favors", into: context)as! Favors
            newitem.setValue(stockSymbol, forKey: "symbol")
            newitem.setValue(Double(self.stockDetail["close"]!), forKey: "price")
            print("ssed")
            newitem.setValue(Double(self.stockDetail["changeOris"]!), forKey: "change")
            newitem.setValue(Double(self.stockDetail["changep"]!), forKey: "changep")
            let currentDateTime = Date()
            newitem.setValue(currentDateTime, forKey: "time")
            star.setImage(UIImage(named: "filled.png"), for: UIControlState.normal)
            do {
                try context.save()
            } catch {
                print("Fail")
            }

        }
   else if star.imageView?.image == UIImage(named: "filled.png"){
        let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
        let predicate = NSPredicate(format: "symbol = '\(String(describing: stockSymbol))' ", "")
        fetchRequest.predicate = predicate
            print("ssed")
        do {
            let fetchedObjects = try context.fetch(fetchRequest)

            for info in fetchedObjects{
                print("symbol=\(String(describing: info.symbol))")
                context.delete(info)
                print("delete")
            }
        }
        catch {
            fatalError("\(error)")
        }
        star.setImage(UIImage(named: "empty.png"), for: UIControlState.normal)
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }

    
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return a.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var testp: UILabel? = (view as? UILabel)
        if testp == nil{
            testp = UILabel()
            testp?.text = a[row]
        }
        return testp!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if a[row] == "Price"{
            path = Bundle.main.path(forResource: "price", ofType: "html")
            graph.loadRequest(NSURLRequest(url: NSURL(string: path!)! as URL) as URLRequest)
            graph.isOpaque = false
            htmls = "$(function(){drawPrice(\"" + stockSymbol! + "\");});"
            print(htmls)
            
        }
        else{
            indi = a[row]
            path = Bundle.main.path(forResource: "indicator", ofType: "html")
            graph.loadRequest(NSURLRequest(url: NSURL(string: path!)! as URL) as URLRequest)
            graph.isOpaque = false
            htmls = "$(function(){drawIndic(\"" + indi! + "\",\"" + stockSymbol! + "\");});"
            print(htmls!)
        }
        
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
