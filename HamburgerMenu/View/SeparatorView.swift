//
//  SeparatorView.swift
//  HamburgerMenu
//
//  Created by lynx on 02/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class SeparatorView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, separatorColor: UIColor?) {
        self.init(frame: frame)
        self.backgroundColor = separatorColor
    }
}
