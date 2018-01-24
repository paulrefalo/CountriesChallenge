//
//  DetailVC.swift
//  Countries
//
//  Created by Paul ReFalo on 1/21/18.
//  Copyright © 2018 QSS. All rights reserved.
//

import UIKit
import MapKit

class DetailVC: UIViewController {
    
    var country = Country()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(country)
        let mapView = MKMapView()
        let latitude = country.latlng[0]
        let longitude = country.latlng[1]
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 150
        let mapWidth:CGFloat = view.frame.size.width - 20
        let mapHeight:CGFloat = view.frame.size.height / 3
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        var divisor = Float(country.area.array.count)
        if divisor < 4 {
            divisor = 4
        } else if divisor < 5 {
            divisor = 3
        } else {
            divisor = 2
        }
        
        let zoom = Float(country.area.array.count * country.area.array.count) / divisor
        
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(zoom), longitudeDelta: CLLocationDegrees(zoom)))
        mapView.setRegion(region, animated: true)
        
        view.addSubview(mapView)
        
        let titleLabel: UILabel = UILabel()
        titleLabel.frame = CGRect(x: leftMargin, y: 70, width: mapWidth, height: 70)
        titleLabel.backgroundColor=UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = country.name
        titleLabel.isHidden = false
        titleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(titleLabel)
        
        let capitalLabel: UILabel = UILabel()
        var y = 70 + 70 + topMargin + 20 + 10 + 90
        capitalLabel.frame = CGRect(x: leftMargin, y: y, width: mapWidth, height: 70)
        capitalLabel.backgroundColor=UIColor.white
        capitalLabel.textAlignment = NSTextAlignment.center
        capitalLabel.text = "Capital: " + country.capital
        capitalLabel.isHidden = false
        capitalLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(capitalLabel)
        
        let populationLabel: UILabel = UILabel()
        y = y + 80
        populationLabel.frame = CGRect(x: leftMargin, y: y, width: mapWidth, height: 70)
        populationLabel.backgroundColor=UIColor.white
        populationLabel.textAlignment = NSTextAlignment.center
        populationLabel.text = "Population: " + String(describing: country.population)
        populationLabel.isHidden = false
        populationLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(populationLabel)
        
    }
    
}

extension Int {
    var array: [Int] {
        return String(self).flatMap{ Int(String($0)) }
    }
}
