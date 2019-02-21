//
//  ViewController.swift
//  03.FIND_YOUR_POSTION
//
//  Created by LamChakkei on 2019/2/21.
//  Copyright © 2019 LamChakkei. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
//判断是否是真机
class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        bgImageView.addSubview(locationLabel)
        bgImageView.addSubview(locationStrLabel)
        bgImageView.addSubview(findButton)
        configUI()
        locationManager.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Mark:config UI
    func configUI() -> Void {
        locationLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(view)
            ConstraintMaker.top.equalTo(view).offset(currentHeight(height: 80))
            ConstraintMaker.height.equalTo(40)
        }
        locationStrLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerX.equalTo(locationLabel)
            ConstraintMaker.top.equalTo(locationLabel).offset(40)
            ConstraintMaker.height.equalTo(40)
        }
        findButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.bottom.equalTo(view).offset(-70)
            ConstraintMaker.centerX.equalTo(view)
            ConstraintMaker.height.equalTo(currentHeight(height: 30))
        }
        
    }
    func currentHeight(height:CGFloat) -> CGFloat {
        return (UIScreen.main.bounds.width/667)*height
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations : NSArray = locations as NSArray
        
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(String(format:"%.2f",currentLocation.coordinate.latitude)) lng:\(String(format:"%.2f",currentLocation.coordinate.longitude))"
        self.locationStrLabel.text = locationStr
        locationLabel.text = locationStr
        reverseCode(location: currentLocation)
        locationManager.stopUpdatingLocation()
        
    }
    
    func reverseCode(location:CLLocation) {
        geoCoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if (error == nil) {
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                let country = mark.country
                
                let locality = mark.locality
                let sublocality = mark.subLocality
                self.locationLabel.text = String(format: "国家:%@ 城市:%@ 辖区:%@ ", country!,locality!,sublocality!)
            }
            else {
                print(error!)
            }
        }
    }
    
    @objc func located() -> Void {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    //Mark:Lazy Load
    lazy var locationLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    lazy var locationStrLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    lazy var findButton : UIButton = {
        let button = UIButton()
        button.setTitle("Find My Position", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(located), for: .touchUpInside)

        return button
    }()
    
    lazy var bgImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
}


