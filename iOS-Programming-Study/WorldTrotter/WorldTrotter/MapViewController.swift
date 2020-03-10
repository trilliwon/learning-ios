//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by WON on 30/07/2018.
//  Copyright © 2018 WON. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView: MKMapView!

    var myFavoriteCities: [MKPointAnnotation] {
        let london = MKPointAnnotation()
        london.title = "London".localized
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)

        let Vancouver = MKPointAnnotation()
        Vancouver.title = "Vancouver".localized
        Vancouver.coordinate = CLLocationCoordinate2D(latitude: 49.2577143, longitude: -123.1939436)

        let Bern = MKPointAnnotation()
        Bern.title = "Bern".localized
        Bern.coordinate = CLLocationCoordinate2D(latitude: 46.9546486, longitude: 7.3248304)
        return [london, Vancouver, Bern]
    }

    override func loadView() {
        // Create a map view
        mapView = MKMapView()

        // Set it as *the* view of this view controller
        view = mapView
        let segmentedControl = UISegmentedControl(items: ["Standard".localized, "Hybrid".localized, "Satellite".localized])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)

        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        trailingConstraint.isActive = true
        leadingConstraint.isActive = true

        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
    }

    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    let locationManager = CLLocationManager()

    let showLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        btn.setTitle("Show Me", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    func configureShowLocationButton() {
        showLocationButton.addTarget(self, action: #selector(showLocationButtonAction), for: .touchUpInside)
        showLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        showLocationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }

    @objc func showLocationButtonAction() {
        print(#function)
        mapView.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        enableBasicLocationServices()
        view.addSubview(showLocationButton)
        configureShowLocationButton()

        myFavoriteCities.forEach {
            mapView.addAnnotation($0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.showsUserLocation = true
    }

    func enableBasicLocationServices() {
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }

        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self

        DispatchQueue.main.async { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }

        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break

        case .restricted, .denied:
            // Disable location features

            break

        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            //
            break
        }
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(region, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            // disable location base feature
            break

        case .authorizedWhenInUse:
            // enable location base feature
            break

        case .notDetermined, .authorizedAlways:
            break
        }
    }
}
