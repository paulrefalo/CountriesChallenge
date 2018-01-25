//
//  DecodableClient.swift
//  Countries
//
//  Created by Paul ReFalo on 1/24/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit

extension CountriesTableVC {

    typealias CompletionHandlerDecodable = (_ success:Bool) -> Void
    
    public func getCountriesDataDecodable(completionHandler: @escaping CompletionHandlerDecodable) {
        
        // define Headers/Parameters
        let methodParameters = [String:AnyObject]()  // add parameters here if needed
        
        // create session and request
        let session = URLSession(configuration: .default) //URLSession.shared
        var request = URLRequest(url: countriesURLFromParametersDecodable(methodParameters))
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
            
            // Decodable parsing
            let decoder = JSONDecoder()
            do {
                let countryData = try decoder.decode([NewCountry].self, from: data)
                
                for c in countryData {
                    if let _ = c.area, let _ = c.latlng {  // check against optionals being nil
                        let newCountry = NewCountry(name: c.name, alpha2Code: c.alpha2Code, capital: c.capital, population: c.population, latlng: (c.latlng)!, area: (c.area)!)
                        self.countriesArray.append(newCountry)
                    }
                }
                completionHandler(true)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(false)
            }
            
        }
        task.resume()
    }
    
    // MARK: Helper for Creating a URL from Parameters
    
    private func countriesURLFromParametersDecodable(_ parameters: [String:AnyObject]) -> URL {
        
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


