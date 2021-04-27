//
//  AppExtensions.swift
//  Schools
//
//  Created by Kevin Garriott on 4/27/21.
//  Copyright © 2021 Kevin Garriott. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}

extension UIViewController {
  // MARK: Alert View defined
  
  func showDismissiveAlertWithMessage(message: String) {
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
}

extension UIColor {
  static let navBarBackground = UIColor(hex: "c91c31")
  static let navBarBackground2 = UIColor(hex: "e7743e")
  static let navBarBackgroundGradient2 = UIColor(hex: "80c2f6")
  
  convenience init(hex: String) {
    self.init(hex: hex, alpha: 1)
  }
  
  convenience init(hex: String, alpha: CGFloat) {
    var hexWithoutSymbol = hex
    if hexWithoutSymbol.hasPrefix("#") {
      let beginSubstring = hex.index(hex.startIndex, offsetBy: 1)
      hexWithoutSymbol = String(hex[beginSubstring...])
    }
    
    let scanner = Scanner(string: hexWithoutSymbol)
    var hexInt: UInt64 = 0x0
    scanner.scanHexInt64(&hexInt)
    
    var red: UInt64!, green: UInt64!, blue: UInt64!
    //switch (hexWithoutSymbol.length) {
    switch hexWithoutSymbol.count {
    case 3: // #RGB
      red = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
      green = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
      blue = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
    case 6: // #RRGGBB
      red = (hexInt >> 16) & 0xff
      green = (hexInt >> 8) & 0xff
      blue = hexInt & 0xff
    default:
      // FIXME:ERROR
      break
    }
    
    self.init(
      red: (CGFloat(red)/255),
      green: (CGFloat(green)/255),
      blue: (CGFloat(blue)/255),
      alpha: alpha)
  }
  
}

extension UIView {
  
  @IBInspectable
  var cornerRadius: CGFloat {
      get {
          return layer.cornerRadius
      }
      set {
          layer.cornerRadius = newValue
          layer.masksToBounds = newValue > 0
      }
  }

  
  
}
