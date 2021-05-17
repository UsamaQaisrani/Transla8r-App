//
//  UIView.swift
//  Transl8or
//
//  Created by Usama on 14/04/2021.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set{
            layer.masksToBounds = newValue
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor : UIColor {
        get{
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set{
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowColor : UIColor {
        get{
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set{
            layer.shadowColor = newValue.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get{
            return layer.shadowOpacity
        }
        set{
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffsetWidth: CGFloat {
        get{
            return layer.shadowOffset.width
        }
        set{
            layer.shadowOffset.width = newValue
        }
    }
    @IBInspectable var shadowOffsetHeight: CGFloat {
        get{
            return layer.shadowOffset.height
        }
        set{
            layer.shadowOffset.height = newValue
        }
    }
}
