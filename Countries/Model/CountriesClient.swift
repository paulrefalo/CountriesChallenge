//
//  CountriesClient.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit

extension CountriesTableVC {
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    public func getCountriesData(completionHandler: @escaping CompletionHandler) {
        
        // define Headers/Parameters
        let methodParameters = [String:AnyObject]()  // add parameters here if needed
        
        // create session and request
        let session = URLSession(configuration: .default) //URLSession.shared
        var request = URLRequest(url: countriesURLFromParameters(methodParameters))
        request.setValue(Constants.CountriesParameterValues.APIKey, forHTTPHeaderField: Constants.CountriesParameterKeys.APIKey)
        request.setValue(Constants.CountriesParameterValues.ResponseFormat, forHTTPHeaderField: Constants.CountriesParameterKeys.Format)
        
        
        print("Request is: \(request)")
        
        // create network request
        var dataTask: URLSessionDataTask?
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(String(describing: error))")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // parse the data
            var parsedResult: [[String:AnyObject]]!
            do {
                //                let parsedCountries = try JSONDecoder().decode(CountryArray.self, from: data)
                //                dump(parsedCountries)
                
                parsedResult = try JSONSerialization.jsonObject(with: data) as! [[String:AnyObject]]
                for country in parsedResult {
                    
                    // convert AnyObject to desired data type
                    if let nameAny = country["name"], let countryCodeAny = country["alpha2Code"],
                        let capitalAny = country["capital"], let populationAny = country["population"],
                        let latlngAny = country["latlng"], let areaAny = country["area"] {
                        
                        let name = String(describing: nameAny)
                        let countryCode = String(describing: countryCodeAny)
                        let capital = String(describing: capitalAny)
                        let population = populationAny as! Int
                    
                        let latlng = latlngAny as! [Float]
                        
                        /* These countries have no valid area
                         United States Minor Outlying Islands
                         Virgin Islands (U.S.)
                         French Guiana
                         Guadeloupe
                         Holy See
                         Martinique
                         Mayotte
                         Monaco
                         Palestine
                         Réunion
                         Saint Helena
                         South Georgia
                         Svalbard and Jan Mayen
                         
                         average country area =  783562
                         */
                        
                        let areaString = String(describing: areaAny)
                        var area = 0
                        if let areaCheck = Int(areaString) {
                            area = areaCheck
                        } else {
                            print(name)
                            area = 783562  // use average country area for now
                        }
                        
                        let newCountry = Country(name: name, countryCode: countryCode, capital: capital, population: population, latlng: latlng, area: area)
                        
                        self.countriesArray.append(newCountry)
                        
                    }
                    
                }
                
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            print(self.countriesArray.count)
            completionHandler(true)
            
        }
        
        task.resume()
    }
    
    // MARK: Helper for Creating a URL from Parameters
    private func countriesURLFromParameters(_ parameters: [String:AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Countries.APIScheme
        components.host = Constants.Countries.APIHost
        components.path = Constants.Countries.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
}
