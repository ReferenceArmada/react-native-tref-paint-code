//
//  TrefPaintCodeHelper.swift
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

import Foundation
import UIKit

@objc(TrefPaintCodeHelper)
class TrefPaintCodeHelper: NSObject {
  
  @objc func prepareColors() -> [AnyHashable: Any] {
    var colors = [AnyHashable: Any]()
    
    let clazz = BundleUtil.getPaintCodeClass()
    
    var count: CUnsignedInt = 0
    if let methods = class_copyPropertyList(object_getClass(clazz.self), &count) {
      for i in 0 ..< count {
        let selector = property_getName(methods.advanced(by: Int(i)).pointee)
        if let key = String(cString: selector, encoding: .utf8) {
            let res = clazz.value(forKey: key) as? UIColor
            colors[key] = toHex(color: res)
        }
      }
      
      free(methods)
    }
    
    return colors
  }
  
  func toHex(color: UIColor?, alpha: Bool = false) -> String? {
    guard let components = color?.cgColor.components, components.count >= 3 else {
      return nil
    }
    
    let r = Float(components[0])
    let g = Float(components[1])
    let b = Float(components[2])
    var a = Float(1.0)
    
    if components.count >= 4 {
      a = Float(components[3])
    }
    
    if alpha {
      return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
    } else {
      return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
  }
  
  @objc func constantsToExport() -> [AnyHashable : Any]! {
    return ["Colors": prepareColors()]
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
