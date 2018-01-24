//
//  Country.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import Foundation

// use struct Country to hold each country and their properties
struct Country {
    let name: String
    let countryCode: String
    
    let capital: String
    
    let population: Int
    let latlng: [Float]
    let area: Int
    
    init(name: String = "iOSastan", countryCode: String = "iOS", capital: String = "Apple",
         population: Int = 1, latlng: [Float] = [45.5, 122.6], area: Int = 1) {
        self.name = name
        self.countryCode = countryCode
        self.capital = capital
        self.population = population
        self.latlng = latlng
        self.area = area
    }

}

//  Maybe use some of these other properties later but skip for now
//    let topLevelDomain: String
//    let alpha3Code: String
//    let callingCodes: String
//    let altSpellings: [String]
//    let region: String
//    let subregion: String
//    let demonym: String
//    let gini: Float
//    let timezones: [String]
//    let boarders: [String]
//    let nativeName: String
//    let numericCode: String
//    let currencies: [String]
//    let languages: [String]
//    let translations: NSDictionary
//    let relevance: String
