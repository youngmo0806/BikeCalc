//
//  DeviceConfig.swift
//  BikeCalc
//
//  Created by kbins on 2021/03/24.
//

import Foundation
import SystemConfiguration


class DeviceManager {
    static let shared: DeviceManager = DeviceManager()
    
    var networkStatus: Bool {
        get{
            return checkDeviceNetworkStatus()
        }
    }
    
    var price: Int?
    var year: Int?
    
    private init(){
        
    }

    private func checkDeviceNetworkStatus() -> Bool {
            print("Check to Device Natwork Status....")
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            // Working for Cellular and WIFI
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            return ret
        }
    
}

struct Rate {
    let newBike = 1.0
    let lessOneYear = 0.703
    let oneYear = 0.562
    let twoYear = 0.464
    let threeYear = 0.316
    let fourYear = 0.215
    let fiveYear = 0.147
    let sixYear = 0.1
}
