//
//  NewCountry.swift
//  Countries
//
//  Created by Paul ReFalo on 1/24/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import Foundation

// use struct Country to hold each country and their properties
struct NewCountry: Decodable {
    
    let name: String
    let alpha2Code: String
    let capital: String    
    let population: Int
    let latlng: [Float]?
    let area: Float?
    
    init(name: String = "Swiftland", alpha2Code: String = "iOS", capital: String = "Portland",
         population: Int = 1, latlng: [Float] = [45.5, 122.6], area: Float = 1.0) {
        self.name = name
        self.alpha2Code = alpha2Code
        self.capital = capital
        self.population = population
        self.latlng = latlng
        self.area = area
    }

}
