//
//  Constants.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit

// MARK: - Constants

struct Constants {
    
    // MARK: Countries
    struct Countries {
        // https://restcountries-v1.p.mashape.com/all
        static let APIScheme = "https"
        static let APIHost = "restcountries-v1.p.mashape.com"
        static let APIPath = "/all"
    }
    
    // MARK: Countries Parameter Keys
    struct CountriesParameterKeys {
        static let Format = "Accept"
        static let APIKey = "X-Mashape-Key"
    }
    
    // MARK: Countries Parameter Values
    struct CountriesParameterValues {
        static let APIKey = "1IosQYQKu0mshuIZjcqiIXbiLGJSp1dBB9Yjsnfd2aISWLA7Yk"
        static let ResponseFormat = "application/json"
    }
    
    // MARK: Countries Response Values
    struct CountriesResponseValues {
        static let OKStatus = "ok"
    }
    
    
}
