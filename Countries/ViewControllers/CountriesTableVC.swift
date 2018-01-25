//
//  CountriesTableVC.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit

class CountriesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating  {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var countriesArray = [NewCountry]()
    var filteredArray = [NewCountry]()
    let searchController = UISearchController(searchResultsController: nil)


    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up search bar
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = self.searchController.searchBar
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        getCountriesDataDecodable(completionHandler: { (success) -> Void in
            // When download completes, control flow and reload table data
            if success {
                // download success
                DispatchQueue.main.async(execute: {() -> Void in
                    self.filteredArray = self.countriesArray
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // instantiate detailVC and hand country object to detail VC
        if segue.identifier == "detailSegue" {
            let selectedRowIndex = tableView.indexPathForSelectedRow?.row
            let detailVC: DetailVC = segue.destination as! DetailVC
            detailVC.country = self.filteredArray[selectedRowIndex!]
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count // countriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        // building cell text with Flag emoji
        var emojiString = String()
        let countryCode = filteredArray[indexPath.row].alpha2Code // placemark.isoCountryCode
        let base : UInt32 = 127397
        for v in (countryCode.unicodeScalars) {
            emojiString.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        // set label text for cell
        cell.textLabel?.text = emojiString + " " + filteredArray[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredArray = countriesArray.filter { country in
                return country.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredArray = countriesArray
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView.reloadData()
        })
    }
    
}


