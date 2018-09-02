//
//  MenuAnimator.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class MenuPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    let duration = 0.2
    var maxWidthPercent: CGFloat = 1
      
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        if let snapshot = fromViewController.view.snapshotView(afterScreenUpdates: false){
            snapshot.isUserInteractionEnabled = false
            let layer = CALayer()
            layer.frame = snapshot.frame
            layer.backgroundColor = UIColor.black.cgColor
            layer.opacity = 0
            snapshot.layer.addSublayer(layer)
            
            snapshot.tag = 100
            transitionContext.containerView.insertSubview(snapshot, aboveSubview: toViewController.view)
            fromViewController.view.isHidden = true

            let screenBounds = UIScreen.main.bounds
            let finalFrameTopLeftCorner = CGPoint(x: screenBounds.width * maxWidthPercent, y: 0)
            let snapshotFinalFrame = CGRect(origin: finalFrameTopLeftCorner, size: screenBounds.size)
            
            UIView.animate(withDuration: duration, animations: {
                snapshot.frame = snapshotFinalFrame
                
            }){ _ in
                    fromViewController.view.isHidden = false
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
