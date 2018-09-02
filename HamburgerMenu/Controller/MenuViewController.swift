//
//  MenuViewController.swift
//  HamburgerMenu
//
//  Created by lynx on 01/09/2018.
//  Copyright © 2018 Gulnaz. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController{
  
    @IBOutlet weak var tableView: UITableView!
    var model = MenuModel()
    var interactor: MenuInteractiveTransition?
    weak var menuDelegate: MenuItemDelegate?
    
    var heightOffset: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan)))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.contentInset = UIEdgeInsets(top: heightOffset, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.dismiss(animated: false, completion: nil)
    }
 
    // MARK: Gestures
    @objc func tap(_ sender: UIPanGestureRecognizer){
        if sender.state == .ended{
            let location = sender.location(in: self.view)
         
            //tap on outside menu
            if let width = self.interactor?.maxWidth, location.x >  width * self.view.bounds.width{
                self.dismiss(animated: true, completion: nil)
            }//or tap on empty space in table
            else if self.tableView.indexPathForRow(at: location) == nil || topScrollOffsetRect().contains(location){
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func topScrollOffsetRect()->CGRect{
        let width = self.tableView.contentInset.left + self.tableView.contentInset.right + self.view.safeAreaInsets.left + self.view.safeAreaInsets.right + self.tableView.bounds.width
        
        let height = self.tableView.contentInset.top + self.view.safeAreaInsets.top
        
        return CGRect(origin: self.tableView.frame.origin, size: CGSize(width: width, height: height))
    }
    
    @objc func pan(_ gesture: UIPanGestureRecognizer){
        interactor?.update(for: gesture, in: self.view, andBeginAction: { [unowned self] in
            self.dismiss(animated: true, completion: nil)
        })
    }
}

// MARK: Table DataSource
extension MenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.menu.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.textCellIdentifier, for: indexPath)
        cell.textLabel?.text = model.menu[indexPath.row].name
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.4941176471, blue: 0.9882352941, alpha: 1)
        cell.selectedBackgroundView = selectedBackgroundView
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.findSubviewOfType(SeparatorView.self)?.removeFromSuperview()
        
        if indexPath.row == 0{
           let separatorInset = self.tableView.separatorInset
           let separatorFrame = UIEdgeInsetsInsetRect(cell.bounds, UIEdgeInsets(top: 0, left: separatorInset.left, bottom: cell.bounds.height - 0.33, right: separatorInset.right))
            let separatorView = SeparatorView(frame: separatorFrame, separatorColor: self.tableView.separatorColor)
            cell.addSubview(separatorView)
        }
    }
}


// MARK: Table Delegate
extension MenuViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMenu = model.menu[indexPath.row]
        
        menuDelegate?.menuSelected(selectedMenu)
        
        self.dismiss(animated: true, completion: nil)
    }
}


