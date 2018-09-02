//
//  UIView+Subviews.swift
//  HamburgerMenu
//
//  Created by lynx on 02/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

extension UIView{
    func findSubviewOfType<T>(_ type: T.Type)->T?{
        if self is T{
            return (self as! T)
        }
        else{
            for subview in self.subviews{
                return subview.findSubviewOfType(type)
            }
        }
        
        return nil
    }
}
