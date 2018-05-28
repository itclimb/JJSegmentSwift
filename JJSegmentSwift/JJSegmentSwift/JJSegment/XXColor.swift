//
//  Colorful.swift
//  IWant
//
//  Created by 李珈旭 on 2016/12/15.
//  Copyright © 2016年 jiaxuLI. All rights reserved.
//

import Foundation
import UIKit
public extension UIColor{
    ///rgb func
    static func RGB (_ R : CGFloat ,_ G : CGFloat ,_ B : CGFloat) -> UIColor{
        
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1)
    }
    ///rgba func
    static func RGBA (_ R : CGFloat ,_ G : CGFloat ,_ B : CGFloat ,_ A : CGFloat) -> UIColor{
        
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
    }
    ///rgbValue func
    static func RGBValue (_ value:UInt32) -> UIColor{
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    ///rgbaValue func
    static func RGBAValue (_ value:UInt32) -> UIColor{
        let r = (value & 0xFF000000) >> 24
        let g = (value & 0x00FF0000) >> 16
        let b = (value & 0x0000FF00) >> 8
        let a = (value & 0x000000FF)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue:CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
    }
    
}
