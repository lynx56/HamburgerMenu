//
//  PercentDrivenInteractiveMenuTransition.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

protocol InteractiveMenuTransitionDelegateProtocol: UIViewControllerTransitioningDelegate {
    var interactiveTransition: MenuInteractiveTransition{ get }
}
