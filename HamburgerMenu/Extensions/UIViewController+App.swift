//
//  UIViewController+App.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

extension UIViewController{
    func contentControllerIgnoringContainers<T>()->Optional<T> where T: UIViewController{
            if let navigationController = self as? UINavigationController{
                return navigationController.topViewController! as? T
            }else{
                return self as? T
            }
    }
}
