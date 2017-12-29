//
//  ViewController.swift
//  stockMarketSearch
//
//  Created by Guannan Lu on 11/28/17.
//  Copyright © 2017 Guannan Lu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import Foundation
import SwiftSpinner
import SearchTextField
import SwiftyJSON
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var sort: UIPickerView!

    @IBOutlet weak var freshbutton: UIButton!
    @IBOutlet weak var order: UIPickerView!
    let pick1:Array = ["Default","Symbol","Price","Change","Change%"]
    let pick2:Array = ["Ascending","Descending"]

    var timer = Timer()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.order{
            return picker2.count
        }
        else{
            return picker1.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var testp: UILabel? = (view as? UILabel)
        if testp == nil{
            testp = UILabel()
            if pickerView == self.sort{
                testp?.text = picker1[row]
            }
            if pickerView == self.order{
                testp?.text = picker2[row]
            }
            
        }
        
        return testp!
    }
    
    var sorting = true
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,  inComponent component: Int) {
       
        if pickerView == self.order{
            if picker2[row] == "Ascending"{
                sorting = true
                print(sorting)
                print("pp")
            }else{
                sorting = false
                print(sorting)
                print("123")
            }
        }
        if pickerView == self.sort{
            print(picker1[row])
            print(sorting)
            print("sd")
            if picker1[row] == "Change"{
                self.favArray = Array<Dictionary<String, Any>>()
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
                do {
                    fetchRequest.sortDescriptors =
                        [NSSortDescriptor(key: "change", ascending: sorting)]

                    let fetchedObjects = try context.fetch(fetchRequest)
                    for info in fetchedObjects{
                        print (info.change)
                        var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                        print("symbol=\(String(describing: info.symbol))")
                    }
                    self.favTable.reloadData()
                }
                catch {
                    fatalError("：\(error)")
                }
            
            }
            
            if pick1[row] == "Default"{
                self.favArray = Array<Dictionary<String, Any>>()
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
                do {
                    fetchRequest.sortDescriptors =
                        [NSSortDescriptor(key: "time", ascending: sorting)]
                    
                    let fetchedObjects = try context.fetch(fetchRequest)
                    for info in fetchedObjects{
                        print (info.change)
                        var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                        print("symbol=\(String(describing: info.symbol))")
                    }
                    self.favTable.reloadData()
                }
                catch {
                    fatalError("\(error)")
                }
                
            }
            
            
            if pick1[row] == "Symbol"{
                self.favArray = Array<Dictionary<String, Any>>()
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
                do {
                    fetchRequest.sortDescriptors =
                        [NSSortDescriptor(key: "symbol", ascending: sorting)]
                    
                    let fetchedObjects = try context.fetch(fetchRequest)
                    for info in fetchedObjects{
                        print (info.change)
                        var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                        print("symbol=\(String(describing: info.symbol))")
                    }
                    self.favTable.reloadData()
                }
                catch {
                    fatalError("：\(error)")
                }
                
            }
            
            
            if pick1[row] == "Change%"{
                self.favArray = Array<Dictionary<String, Any>>()
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
                do {
                    fetchRequest.sortDescriptors =
                        [NSSortDescriptor(key: "changep", ascending: sorting)]
                    
                    let fetchedObjects = try context.fetch(fetchRequest)
                    for info in fetchedObjects{
                        print (info.change)
                        var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                        print("symbol=\(String(describing: info.symbol))")
                    }
                    self.favTable.reloadData()
                }
                catch {
                    fatalError("：\(error)")
                }
                
            }
            
            if pick1[row] == "Price"{
                self.favArray = Array<Dictionary<String, Any>>()
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
                do {
                    fetchRequest.sortDescriptors =
                        [NSSortDescriptor(key: "price", ascending: sorting)]
                    
                    let fetchedObjects = try context.fetch(fetchRequest)
                    for info in fetchedObjects{
                        print (info.change)
                        var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                        print("symbol=\(String(describing: info.symbol))")
                    }
                    self.favTable.reloadData()
                }
                catch {
                    fatalError("\(error)")
                }
                
            }
            
            
            
            
        }

    }
var favArray : Array<Dictionary<String, Any>> = Array<Dictionary<String, Any>>()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell()
        //cell.textLabel?.text = "123"
         let cell = favTable.dequeueReusableCell(withIdentifier: "favRow", for: indexPath) as! favCellTableViewCell
        cell.sym.text = String(describing: favArray[indexPath.row]["s"]!)
        cell.pri.text = String(describing: favArray[indexPath.row]["p"]!)
        let xx = String(describing: favArray[indexPath.row]["c"]!) + "("
        let dd = String(describing: favArray[indexPath.row]["cp"]!) + "%)"
        cell.changes.text = String(xx+dd)
        print(cell.changes.text!)
        return cell
    }
    
    @objc func loadFav() {
        switchlist.stopAnimating()
        //switchlist.hidesWhenStopped = true
        freshl.stopAnimating()
        self.favArray = Array<Dictionary<String, Any>>()
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Favors>(entityName:"Favors")
        do {
            let fetchedObjects = try context.fetch(fetchRequest)

            for info in fetchedObjects{
                print (info.change)
                    var newsRow: Dictionary<String, Any> = Dictionary<String, Any>()
                        newsRow["s"] = info.symbol
                        newsRow["p"] = info.price
                        newsRow["c"] = info.change
                        newsRow["cp"] = info.changep
                        newsRow["t"] = info.time
                        self.favArray.append(newsRow)
                        newsRow.removeAll()
                print("symbol=\(String(describing: info.symbol))")
            }
            self.favTable.reloadData()
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:

            //tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            print("is delete")
            favTable.reloadData()
        default:
            return
        }
    }
    
    
    
    
    var stockDetail: Array<Dictionary<String, String>>?
   // var stockSymbol: String?
    var stockSymbol = ""

    @IBOutlet weak var textInput: SearchTextField!
    @IBOutlet weak var getQuoteButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var favTable: UITableView!
    
    @IBOutlet weak var switchlist: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        autocomplete()
        loadFav()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func switchauto(_ sender: UISwitch) {
        if sender.isOn {
            timer.invalidate()
            switchlist.startAnimating()
            //freshl.startAnimating()
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.loadFav), userInfo: nil, repeats: true)
            
        } else {
            switchlist.stopAnimating()
            //switchlist.hidesWhenStopped = true
            //timer.invalidate()
        }
    }
 
    
    func autocomplete(){
        textInput.theme = SearchTextFieldTheme.lightTheme()
        
        // Modify current theme properties
        textInput.theme.font = UIFont.systemFont(ofSize: 12)
        textInput.theme.bgColor = UIColor.lightGray.withAlphaComponent(0.2)
        textInput.theme.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        textInput.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        textInput.theme.cellHeight = 40
        textInput.theme.placeholderColor = UIColor.lightGray
        
        // Max number of results - Default: No limit
        textInput.maxNumberOfResults = 5
        
        // Max results list height - Default: No limit
        textInput.maxResultsListHeight = 200
        
        // Set specific comparision options - Default: .caseInsensitive
        textInput.comparisonOptions = [.caseInsensitive]
        
        // You can force the results list to support RTL languages - Default: false
        textInput.forceRightToLeft = false
        
        
        
        // Handle item selection - Default behaviour: item title set to the text field
        textInput.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
   
            //stockSymbol =
            let str = item.title
            let start = str.index(str.startIndex, offsetBy: 0)
             print(start)
            print("ss")
            let ended = str.index(of: "-")
            print("Item at position \(itemPosition): \(item.title)")
            print (ended!)
           
            
            let res = String(str[start ..< ended!])
            let end1 = res.index(res.endIndex, offsetBy: -1)
            let sym = "\(res[start..<end1])"
 
            print (res)
            self.textInput.text = res
            self.stockSymbol = res
        }

        textInput.userStoppedTypingHandler = {
            if let criteria = self.textInput.text {
                if criteria.count > 0 {
                    
                    // Show loading indicator
                    self.textInput.showLoadingIndicator()
                    
                    self.filterAcronymInBackground(criteria) { results in
                        // Set new items to filter
                        self.textInput.filterItems(results)
                        
                        // Stop loading indicator
                        self.textInput.stopLoadingIndicator()
                    }
                }
            }
            } as (() -> Void)
        
    }
    
    
    fileprivate func filterAcronymInBackground(_ criteria: String, callback: @escaping ((_ results: [SearchTextFieldItem]) -> Void)) {
        let url = URL(string: "http://dev.markitondemand.com/MODApis/Api/v2/Lookup/json?input=\(criteria)")
        
        if let url = url {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
                do {
                    if let data = data {
                        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:AnyObject]]
                        
                        if let firstElement = jsonData.first {
                            print(firstElement)
                            print("the element is before")
                            var results = [SearchTextFieldItem]()
                            
                            for result in jsonData {
                                let a = "\(String(describing: result["Symbol"]!))"
                                let b =  "- " + "\(String(describing: result["Name"]!))"
                                let c = " (" + "\(String(describing: result["Exchange"]!))" + ")"
                                let d = a + b + c
                                results.append(SearchTextFieldItem(title: d ))
                            }
                            
                            DispatchQueue.main.async {
                                callback(results)
                            }
                        } else {
                            DispatchQueue.main.async {
                                callback([])
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            callback([])
                        }
                    }
                }
                catch {
                    print("Network error: \(error)")
                    DispatchQueue.main.async {
                        callback([])
                    }
                }
            })
            
            task.resume()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        //SwiftSpinner.show("Loading...").addTapHandler({
        //    SwiftSpinner.hide()
        //})
    }
  
    
    @IBOutlet weak var freshl: UIActivityIndicatorView!
    
    @IBAction func refresh() {
        freshl.startAnimating()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.loadFav), userInfo: nil, repeats: false)
    }
    
    @IBAction func click(){
        performSegue(withIdentifier: "aaaa", sender: self)
        getJson(input:stockSymbol)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let symbol: Detail = segue.destination as! Detail
        if segue.identifier == "aaaa" {
            symbol.stockSymbol = stockSymbol
        }
    }

    @IBAction func clickClear(){
        textInput.text = ""
    }
    
    
    func getJson (input: String) {
        //stockSymbol = "aapl"
        SwiftSpinner.show("Loading Data")
        print(stockSymbol)
        Alamofire.request("http://nodejs-env1.us-west-1.elasticbeanstalk.com/stock.json",parameters: ["input": stockSymbol]).responseSwiftyJSON { response in
            let jsonData = response.result.value //A JSON object
            let isSuccess = response.result.isSuccess
            if (isSuccess && (jsonData != nil)) {
                // to ask for the data here!!
                SwiftSpinner.hide()


            }
        }
    }

}

