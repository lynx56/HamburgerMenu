//
//  MenuAnimator.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class MenuDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    let duration = 0.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        if let snapshot = transitionContext.containerView.viewWithTag(100)
        {
                UIView.animate(withDuration: duration, animations: {
                snapshot.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)}){ _ in
                    if transitionContext.transitionWasCancelled{
                        transitionContext.completeTransition(false)
                    }else{
                        transitionContext.containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
                        snapshot.removeFromSuperview()
                        transitionContext.completeTransition(true)
                    }
            }
        }
    }
}
