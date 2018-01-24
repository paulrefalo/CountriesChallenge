//
//  CountriesTableVC.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit

class CountriesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    var countriesArray = [Country]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCountriesData(completionHandler: { (success) -> Void in
            
            // When download completes,control flow goes here.
            if success {
                // download success
                DispatchQueue.main.async(execute: {() -> Void in
                    self.tableView?.reloadData();
                })
            } else {
                // download fail
                print("Could not complete country download")
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Countries"
        
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // instantiate detailVC and hand country object to detail VC
        if segue.identifier == "detailSegue" {
            let selectedRowIndex = tableView.indexPathForSelectedRow?.row
            let detailVC: DetailVC = segue.destination as! DetailVC
            detailVC.country = self.countriesArray[selectedRowIndex!]
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CountriesCustomCell
        // building cell text with Flag emoji
        var emojiString = String()
        let countryCode = countriesArray[indexPath.row].countryCode // placemark.isoCountryCode
        let base : UInt32 = 127397
        for v in (countryCode.unicodeScalars) {
            emojiString.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        // set label text for cell
        cell.textLabel?.text = emojiString + " " + countriesArray[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)

    }
    
}


