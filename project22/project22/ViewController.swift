//
//  ViewController.swift
//  project22
//
//  Created by ISYS Macbook air 1 on 06/06/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!
    
    var locationManager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }
    
    //    @available(iOS 14.0, *) ????
    //    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    //        if manager.authorizationStatus == .authorizedAlways {
    //            if CLLocationManager.isMonitoringAvailable(for: CLLocation.self){
    //                if CLLocationManager.isRangingAvailable() {
    //                    // To do stuff
    //                }
    //            }
    //        }
    //    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable(){
                    // Todo stuff
                    startScanning()
                    
                }
            }
        }
    }
    
    func startScanning(){
        guard let uuid = UUID(uuidString: "") else{ return }
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
        
    }
    
    func update(distance: CLProximity){
        UIView.animate(withDuration: 1){
            switch distance{
            case .far :
                self.distanceReading.text = "Far"
                self.view.backgroundColor = .blue
            case .near :
                self.distanceReading.text = "Near"
                self.view.backgroundColor = .orange
            case .immediate :
                self.distanceReading.text = "Right Here"
                self.view.backgroundColor = .red
            default:
                self.distanceReading.text = "UNKNOWN"
                self.view.backgroundColor = .gray
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        if let beacon = beacons.first{
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
    
    
    
}

