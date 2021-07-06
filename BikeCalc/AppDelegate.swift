//
//  AppDelegate.swift
//  BikeCalc
//
//  Created by kbins on 2021/03/24.
//

import UIKit
import GoogleMobileAds


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
//        let activity:UIActivityIndicatorView = UIActivityIndicatorView.init(frame: CGRect(x: 225, y: 115, width: 30, height: 30))
//        activity.startAnimating()
//        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]  initWithFrame:CGRectMake(225, 115, 30, 30)];
//
//        [activity setBackgroundColor:[UIColor clearColor]];
//
//        [activity setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray];
//
//        [self.view addSubview: activity];
//
//        [activity startAnimating];
        
        
        if #available(iOS 14, *) {
            
        }
        
        
        
        //Google Demo ID
        //배너광고 운영    ca-app-pub-7013457434188658~1568959665
        //배너광고 DemoId ca-app-pub-3940256099942544/2934735716
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}
