//
//  ViewController.swift
//  GoogleMapSDKVersion3
//
//  Created by デュフフくん on 2020/02/12.
//  Copyright © 2020 Naoki-Yuzu. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var cgrect: CGRect!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var camera: GMSCameraPosition!

    /* safaAreaの値を取得 */
    var safaAreaHeight:CGFloat = 0
    var safeAreaWidth:CGFloat = 0
    var topPadding:CGFloat = 0
    var buttomPadding:CGFloat = 0
    var leftPadding:CGFloat = 0
    var rightPadding:CGFloat = 0

    /* viewの幅と高さを取得するための変数 */
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0

    /* 位置情報を管理するための変数 */
    var locationManeger:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingLocationManeger()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

            screenWidth = view.frame.size.width
            screenHeight = view.frame.size.height

            let safeArea =  self.view.safeAreaInsets
            topPadding = safeArea.top
            buttomPadding = safeArea.bottom
            leftPadding = safeArea.left
            rightPadding = safeArea.right

            if screenWidth > screenHeight {

                safaAreaHeight = screenHeight
                safeAreaWidth = screenWidth - leftPadding - rightPadding
                cgrect = CGRect(x: leftPadding, y: topPadding, width: safeAreaWidth, height: safaAreaHeight)
                let mapView = GMSMapView(frame: cgrect, camera: camera)
                mapView.isMyLocationEnabled = true
                view.addSubview(mapView)

            } else {

                safaAreaHeight = screenHeight - topPadding - buttomPadding
                safeAreaWidth = screenWidth - leftPadding - rightPadding
                print("topPaddingだよ:\(topPadding as Any)")
                print("view.frameだよ:\(self.view.frame)")
                cgrect = CGRect(x: leftPadding, y: topPadding, width: safeAreaWidth, height: safaAreaHeight)
//                print(camera)
//                print(cgrect)
//                let mapView = GMSMapView(frame: cgrect, camera: camera)
                let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
                let mapView2 = GMSMapView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), camera: camera)
                mapView2.isMyLocationEnabled = true
                view.addSubview(mapView2)

            }


        }

    /* 位置情報を取得・更新するたびに呼ばれる */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first

        latitude = location?.coordinate.latitude ?? 0
        longitude = location?.coordinate.longitude ?? 0
        camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 1.0)
//        let locationOfCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        /* mapViewの中心をユーザーがいる場所に設定 */
//        mapView.setCenter(locationOfCoordinate, animated: true)
        
//        var region: MKCoordinateRegion = mapView.region
//        region.center = locationOfCoordinate
//        region.span.latitudeDelta = 0.001
//        region.span.longitudeDelta = 0.001
        
        /* ピンを生成 */
//        let pointAnnotation:MKPointAnnotation = MKPointAnnotation()
//        pointAnnotation.coordinate = locationOfCoordinate
//        pointAnnotation.title  = "現在地"
//
//        mapView.addAnnotation(pointAnnotation)
//        mapView.setRegion(region, animated: true)
//        mapView.mapType = MKMapType.standard
        
        /* 位置情報の取得を止める */
        locationManeger.stopUpdatingLocation()


    }


}

extension ViewController {

    func settingLocationManeger() {
        locationManeger = CLLocationManager()
        guard locationManeger != nil else { return }

        locationManeger.requestAlwaysAuthorization()

        let status = CLLocationManager.authorizationStatus()

        switch status {
        case .restricted, .denied:
            break

        case .authorizedWhenInUse, .authorizedAlways:
            locationManeger.delegate = self
            locationManeger.distanceFilter = 1
            locationManeger.startUpdatingLocation()

        case .notDetermined:
            locationManeger.requestAlwaysAuthorization()
            locationManeger.delegate = self
            locationManeger.startUpdatingLocation()

        default:
            break
        }

    }

}

