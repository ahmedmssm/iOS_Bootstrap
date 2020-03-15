//
//  RxSwiftExtensions.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 3/13/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import RxSwift
import iOS_Bootstrap

extension Observable {
    func applyThreadingConfig() -> Observable {
        return self
            .subscribeOn(Schedulers.backgroundConcurrentScheduler)
            .observeOn(Schedulers.uiScheduler)
    }
}

extension PrimitiveSequence {
    func applyThreadingConfig() -> PrimitiveSequence {
        return self
            .subscribeOn(Schedulers.backgroundConcurrentScheduler)
            .observeOn(Schedulers.uiScheduler)
    }
}


extension Completable {
    func applyThreadingConfig() -> Completable {
        return self
            .subscribeOn(Schedulers.backgroundConcurrentScheduler)
            .observeOn(Schedulers.uiScheduler)
    }
}