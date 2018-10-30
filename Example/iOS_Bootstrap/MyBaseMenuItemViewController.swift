//
//  MyBaseMenuItemViewController.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 10/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iOS_Bootstrap

class MyBaseMenuItemViewController <P, V> : BaseMenuItemViewController <P, V> where P : BasePresenter<V> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLeftSideMenuNavigationBarItem(icon: #imageLiteral(resourceName: "thumbs-up"))
    }
    
}

