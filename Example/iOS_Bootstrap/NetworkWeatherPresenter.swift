//
//  NetworkWeatherPresenter.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 10/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

class NetworkWeatherPresenter : BasePresenter<NetworkWeatherViewDelegator> {
    
    required init(viewDelegator: NetworkWeatherViewDelegator) {
        super.init(viewDelegator: viewDelegator)
    }
    
    override func viewControllerDidLoaded() { getFiveDaysWeather() }
    
    private func getFiveDaysWeather() {
        getViewDelegator().loadingDidStarted!()
        APIsConnector.sharedInstance.getFiveDaysWeatherForcastWithNetworkProvidedLocation() { response in
            self.getViewDelegator().didFinishedLoading?()
            switch response {
            case .success(let weatherFocast):
                self.getViewDelegator().didGetFiveDaysWeather(weatherForcast: weatherFocast)
                break
            case .failure(let errorMessage):
                self.getViewDelegator().didFailToGetFiveDaysWeather(errorMessage: errorMessage)
                break
            }
        }
    }
    
}

