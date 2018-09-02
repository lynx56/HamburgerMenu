//
//  MenuInteractiveTransition
//  HamburgerMenu
//
//  Created by lynx on 02/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class MenuInteractiveTransition: UIPercentDrivenInteractiveTransition{
    var maxWidth: CGFloat = 0.8
    var shouldFinish: Bool{
        return self.percentComplete > 0.3
    }
}
