//
//  Utilities.swift
//  Schools
//
//  Created by Kevin Garriott on 4/27/21.
//  Copyright © 2021 Kevin Garriott. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit



class Utilities {
  
  struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
      navBar.setBackgroundImage(UIImage(), for: .default)
      navBar.shadowImage = UIImage()
      navBar.isTranslucent = true
    }
  }
  
  // Function for Checking Internet Connection
  class func connectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
        SCNetworkReachabilityCreateWithAddress(nil, $0)
      }
    }) else {
      return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
  }
  
}
