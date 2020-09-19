//
//  Map.swift
//  Media Finder
//
//  Created by Hossam on 8/10/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AddressSendingDelegate: class{
    func sendAddress (address: String, tag:Int)
}

class Map: UIViewController {
    
    

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    
     weak var delegate: AddressSendingDelegate?
    lazy var geoCoder = CLGeocoder()
    var tag = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    


    @IBAction func confirmationBTN(_ sender: UIButton) {
        //3-
       // delegate?.sendAddress(addressLabel.text!)
        self.navigationController?.popViewController(animated: true)
            
    }
}

extension Map: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView , regionDidChangeAnimated animated: Bool)
    {
    let center = mapView.centerCoordinate
    getNameOfLocation(lat: center.latitude , long: center.longitude)
    
    }
}


extension Map {
    private func getNameOfLocation (lat:CLLocationDegrees, long:CLLocationDegrees){
        let location = CLLocation(latitude: lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(location) { ( placemarks , error) in
            self.processResponce(withPlacemarks: placemarks, error: error)
            
        }
        
    }
    
    private func processResponce(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if error != nil {
            addressLabel.text = "Unable to Find Address for Location"
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                addressLabel.text = placemark.compactAddress ?? ""
                delegate?.sendAddress(address: placemark.compactAddress ?? "N/A", tag: tag) }
            else {
                addressLabel.text = "No Matching Address Found"
                delegate?.sendAddress(address: "No Matching Address Found" , tag: tag)
                
            }
        }
    }
}



