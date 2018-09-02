//
//  MenuModel.swift
//  HamburgerMenu
//
//  Created by lynx on 02/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import Foundation

class MenuModel{
    var menu: [MenuItem] = []
    var defaultMenu: MenuItem
    
    init(){
        for i in 1...5{
            menu.append(MenuItem(name: "\(i) Пункт меню", value: i))
        }
        
        defaultMenu = menu[0]
    }
}
