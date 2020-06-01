//
//  TrefPaintCode.swift
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

import Foundation
import UIKit

class PaintCodeView: UIView {
  
  @objc var method: String = ""
  @objc var params: [AnyHashable : Any] = [:]
  
  override func draw(_ rect: CGRect) {
    
    let clazz: AnyClass = BundleUtil.getPaintCodeClass()
    
    var methodCount: UInt32 = 0
    let methodList = class_copyMethodList(object_getClass(clazz), &methodCount)
    
    if let list = methodList {
      for i in 0..<Int(methodCount) {
        let selName = sel_getName(method_getName(list[i]))
        let methodName = String(cString: selName, encoding: String.Encoding.utf8)!
        if methodName.contains(method as String) {
          method = methodName
          break
        }
      }
      
      free(methodList)
    }
    
    let engine = DrawerEngine()
    engine.run(rect, method: method, params: params)
  }
}

@objc(TrefPaintCode)
class TrefPaintCode: RCTViewManager {
  
  override func view() -> UIView! {
    return PaintCodeView()
  }
  
  override class func requiresMainQueueSetup() -> Bool {
    return true
  }
}
