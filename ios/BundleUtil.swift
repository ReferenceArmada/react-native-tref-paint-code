//
//  BundleUtil.swift
//  TrefPaintCode
//
//  Created by The Reference Armada on 20.02.2020.
//  The Reference
//

import Foundation

@objc(BundleUtil)
public class BundleUtil: NSObject {

    @objc public class func getPaintCodeClass() -> AnyClass {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            fatalError("Cannot retrieve CFBundleName. Terminating.")
        }
        
        let className = bundleName + ".PaintCode"
        
        guard let clazz = NSClassFromString(className) else {
            fatalError("There is no PaintCode class on the project. Terminating.")
        }
        
        return clazz
    }
}
