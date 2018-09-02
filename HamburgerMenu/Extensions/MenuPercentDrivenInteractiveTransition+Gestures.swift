//
//  MenuPercentDrivenInteractiveTransition+Gestures.swift
//  HamburgerMenu
//
//  Created by lynx on 02/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

extension MenuInteractiveTransition{
    func update(for gesture: UIPanGestureRecognizer, in view: UIView, andBeginAction action: (()->Void)?){
        let translation = gesture.translation(in: view)
        
        let progress = abs(translation.x/view.bounds.width)
        switch gesture.state {
        case .began:
            action?()
        case .changed:
            self.update(progress)
        case .cancelled:
            self.cancel()
        case .ended:
            if self.shouldFinish{
                self.finish()
            }else{
                self.cancel()
            }
        default:
            break
        }
    }
}
