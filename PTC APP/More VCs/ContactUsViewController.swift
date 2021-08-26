//
//  ContactUsViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-05.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ContactUsViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: - Outlet
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var knowMoreAboutUsButton: UIButton!
    
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
    }
    

    //MARK: - Map Rendering
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        
        //Coordinates of Connect to The Core
        let latitude: CLLocationDegrees = 43.484677
        let longitude: CLLocationDegrees = -79.643007
        
        //Set coordinate and span
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        //Set region
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        //Add pin on map
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        pin.title = "Connect To The Core"
    }

    //Set up and style the elements
    func setupElements() {
      
        //Style purchase button
        Utilities.styleButton(knowMoreAboutUsButton)
        
        //Style mapView
        mapView.layer.borderColor = Utilities.brandRedColor.cgColor
        mapView.layer.borderWidth = 1
    }
    
    
    //MARK: - IBActions
    
    @IBAction func knowMoreAboutUsButtonTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://www.connecttothecore.com")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func instagramButtontapped(_ sender: UIButton) {
       UIApplication.shared.open(URL(string: "https://www.instagram.com/connecttothecore/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.facebook.com/Connect-To-The-Core-Inc-244517470006/")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func twitterButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://twitter.com/TeresaEasler")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func youtubeButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.youtube.com/channel/UCWjLdrHSw6nQDYXrCWQw9IA/playlists")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func linkedInButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.linkedin.com/uas/login?session_redirect=https%3A%2F%2Fwww.linkedin.com%2Fcompany%2F802137%2Fadmin%2F")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func soundCloudButtonTapped(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://soundcloud.com/teresa-easler")!, options: [:], completionHandler: nil)
    }
}
