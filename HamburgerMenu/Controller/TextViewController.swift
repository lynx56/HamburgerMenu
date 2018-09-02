//
//  ViewController.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, MenuItemDelegate {
    var interactiveTransitionDelegate: InteractiveMenuTransitionDelegateProtocol = InteractiveMenuTransitionDelegate()
  
    @IBOutlet weak var textLabel: UILabel!
    //todo: Sharing
    var model = MenuModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan))
        edgePanGesture.edges = .left
        
        self.view.addGestureRecognizer(edgePanGesture)
        
        self.transitioningDelegate = interactiveTransitionDelegate
        
        updateMenuMaxWidthPercent()
        
        menuSelected(model.defaultMenu)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        updateMenuMaxWidthPercent()
    }
    
    func updateMenuMaxWidthPercent(){
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            self.interactiveTransitionDelegate.interactiveTransition.maxWidth = 0.4
        }else{
            self.interactiveTransitionDelegate.interactiveTransition.maxWidth = 0.8
        }
    }
    
    @objc func edgePan(gesture: UIScreenEdgePanGestureRecognizer){
        interactiveTransitionDelegate.interactiveTransition.update(for: gesture, in: self.view) { [unowned self] in
            self.performSegue(withIdentifier: Storyboard.showMenuSegueIdentifier, sender: nil)
        }
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller: MenuViewController = segue.destination.contentControllerIgnoringContainers(){
            controller.transitioningDelegate = interactiveTransitionDelegate
            controller.interactor = interactiveTransitionDelegate.interactiveTransition
            controller.menuDelegate = self
            if let navBarHeight = self.navigationController?.navigationBar.bounds.height{
                controller.heightOffset = navBarHeight
            }
        }
    }
    
    @objc func openMenu(_ sender: Any?){
        self.performSegue(withIdentifier: Storyboard.showMenuSegueIdentifier, sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: MenuItemDelegate
    func menuSelected(_ item: MenuItem) {
        self.navigationItem.title = item.name
        self.textLabel.text = "\(item.value)"
    }
}


protocol MenuItemDelegate: class{
    func menuSelected(_ item: MenuItem)
}

enum PanDirection{
    case Right, Left
}



