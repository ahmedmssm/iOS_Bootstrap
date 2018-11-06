//
//  NetworkWeatherViewDelegator.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 10/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

protocol NetworkWeatherViewDelegator : BaseViewDelegator {
    func didGetTenDaysWeather(weatherForcast : WeatherForcast)
    func didFailToGetTenDaysWeather(errorMessage : String)
}

