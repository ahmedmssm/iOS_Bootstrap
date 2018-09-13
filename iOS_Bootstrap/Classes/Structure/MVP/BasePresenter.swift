//
//  BasePresenter.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 6/28/18.
//  Copyright © 2018 Ahmad Mahmoud. All rights reserved.
//


open class BasePresenter <T> : UserDefaultsService {
    
    public final let getViewDelegator: T!
    
    private let userDefaultsManager : UserDefaultsManager!

    required public init (contract : T) {
        self.getViewDelegator = contract
        userDefaultsManager = UserDefaultsManager()
    }
    
    public func getUserDefaults() -> UserDefaultsManager { return userDefaultsManager }
    
}

