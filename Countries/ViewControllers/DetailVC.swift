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

    // MARK: Properties
    var country = NewCountry()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up Label and Map views
        addLabels()
        addMapView()
        
        print(country)  // print to console for T/S

    }
    
    func addMapView() {
        let mapView = MKMapView()
        mapView.frame = CGRect.zero
        
        var latitude: Float = 0.0
        var longitude: Float = 0.0 
        
        if var latlong = country.latlng {
            latitude = latlong[0]
            longitude = latlong[1]
        }
        
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = (view.frame.size.height / 2) - 20
        let mapTop:CGFloat = (view.frame.size.height / 6) - 10
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // create poor man's algorith to zoom map to reasonable span for viewing countries of different sizes
        if let digitsFloat = country.area {
            let digitsInt = Int(digitsFloat)    // get the number of digits in the country's area
            
            var divisor = Float(digitsInt.array.count)  // set divisor for algorithm
            if divisor < 4 {
                divisor = 4
            } else if divisor < 5 {
                divisor = 3
            } else {
                divisor = 2
            }
            
            // algorithm to adjust map span proportional to country area
            let zoom = Float(digitsInt.array.count * digitsInt.array.count) / divisor
            
            // set map reagion: center and span
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(zoom), longitudeDelta: CLLocationDegrees(zoom)))
            mapView.setRegion(region, animated: true)
            
        }
        
        view.addSubview(mapView)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: mapTop),
            mapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapHeight),
            mapView.widthAnchor.constraint(equalToConstant: mapWidth)
            ])
    }
    
    func addLabels() {
        let labelHeight = (view.frame.size.height / 6) - 20
        
        // titleLabel
        let titleLabel: UILabel = UILabel()
        titleLabel.frame = CGRect.zero
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor=UIColor.white
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = country.name
        titleLabel.isHidden = false
        titleLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(titleLabel)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        
        // populationLabel
        let populationLabel: UILabel = UILabel()
        populationLabel.frame = CGRect.zero
        
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        populationLabel.backgroundColor=UIColor.white
        populationLabel.textAlignment = NSTextAlignment.center
        populationLabel.text = "Population: " + String(describing: country.population)
        populationLabel.isHidden = false
        populationLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(populationLabel)
        
        NSLayoutConstraint.activate([
            populationLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -labelHeight - 5),
            populationLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            populationLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            populationLabel.heightAnchor.constraint(equalToConstant: labelHeight - 10)
            ])
        
        // capitalLabel
        let capitalLabel: UILabel = UILabel()
        capitalLabel.frame = CGRect.zero
        
        capitalLabel.translatesAutoresizingMaskIntoConstraints = false
        capitalLabel.backgroundColor=UIColor.white
        capitalLabel.textAlignment = NSTextAlignment.center
        capitalLabel.text = "Capital: " + country.capital
        capitalLabel.isHidden = false
        capitalLabel.adjustsFontSizeToFitWidth = true
        view.addSubview(capitalLabel)
        
        NSLayoutConstraint.activate([
            capitalLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0),
            capitalLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            capitalLabel.heightAnchor.constraint(equalToConstant: labelHeight - 10)
            ])
    }
    
}

extension Int {
    var array: [Int] {
        return String(self).flatMap{ Int(String($0)) }
    }
}
