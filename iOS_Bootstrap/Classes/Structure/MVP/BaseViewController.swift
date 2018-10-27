//
//  BaseViewController.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 6/30/18.
//  Copyright © 2018 Ahmad Mahmoud. All rights reserved.
//

import UIKit

open class BaseViewController <T, V> : UIViewController where T : BasePresenter<V> {

    private var presenter : T!
    
    override open func viewDidLoad() {
        // self.getPresenter = T.init(contract: self as! V)
        self.presenter = T.init()
        initUI()
    }
    //
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewWillAppearEssentials()
    }
    //
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        InternetConnectionManager.getInstance.removeListener(listener: self)
        setupViewDidDisappearEssentials()
    }
    
    public final var getPresenter : T {
        get {
            if (presenter.getViewDelegator == nil) {
                presenter.attachView(contract: self as! V)
            }
            return presenter
        }
    }

    open func initUI () { fatalError("Must Override") }

}


