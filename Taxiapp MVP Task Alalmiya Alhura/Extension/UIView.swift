//
//  UIView.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import Foundation
import UIKit
extension UIView {
    // cornerRadius View

  @IBInspectable var cornerRadius: CGFloat {

   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }
    // borderWidth View

  @IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
  }
    
    // borderColor View
  @IBInspectable var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
  }
    
    
    
    // constraint the view to cusomize in all screen
     func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
}
