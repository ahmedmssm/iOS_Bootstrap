
//
//  API_Connector.swift
//  NetworkAbstractLayer_sample
//
//  Created by Ahmad Mahmoud on 4/7/18.
//  Copyright © 2018 Ahmad Mahmoud. All rights reserved.
//

import iOS_Bootstrap
import RxSwift

class API_Connector : GenericConnector {
    
    private final var apiProvider : APIsProvider<APIs>!
    
    required override init() {
        super.init()
        GenericErrorConfigurator.defaultErrorHandler(HumanReadableErrorHandler())
        // With plugins
        //
        // let networkLogger = NetworkLoggerPlugin(verbose: true)
        // With formatted output
        let networkLogger = NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
        //
        let plugins : [PluginType] = [networkLogger]
        apiProvider = APIsProvider<APIs>(plugins: plugins)
        // Without plugins
        // apiProvider = APIsProvider<APIs>()
    }
    
    // Write your network calls here
    func getAllCountries (completion: @escaping completionHandler<[Country]>) {
        let _ = apiProvider.rx
            .request(.getWorldCountries())
            .filterSuccessfulStatusAndRedirectCodesAndProcessErrors()
            .asObservable()
            .refreshAuthenticationTokenIfNeeded(sessionServiceDelegate: self)
            .asSingle()
          //  .mapString()
            .mapArray(Country.self)
            .subscribe { event in
                switch event {
                case .success(let response):
                    completion(.success(response))
                case .error(let error):
                    completion(.failure(error.localizedDescription))
                }}
    }
    
    override func getTokenRefreshService() -> Single<Response> {
//               return
//                    apiProvider.rx
//                        .request(.doRequestThatReturnsAnError())
        
//                return
//                    apiProvider.rx
//                        .request(.getWorldCountries())
        
        return
            apiProvider.rx
                .request(.getCountryDetailsByCountryName(countryName: ""))
    }
    
    func getFakeUsers (page : Int, completion: @escaping completionHandler<Page>) {
        let _ = apiProvider.rx
            .request(.getUsers(page: String(page)))
            //.showLoading()
            .filterSuccessfulStatusAndRedirectCodes()
            .refreshAuthenticationTokenIfNeeded(sessionServiceDelegate: self)
            .map(Page.self)
            .subscribe { event in
                switch event {
                case .success(let page) :
                    completion(.success(page))
                case .error(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    
    func getErrorFromRequest (completion: @escaping completionHandler<[Country]>) {
        let _ = apiProvider.rx
            .request(.doRequestThatReturnsAnError())
            .filterSuccessfulStatusAndRedirectCodesAndProcessErrors()
            .refreshAuthenticationTokenIfNeeded(sessionServiceDelegate: self)
            .mapString()
            .subscribe { event in
                switch event {
                case .success(let responseString):
                    let countries : [Country] = Parser.arrayOfObjectsFromJSONstring(object: Country.self, JSONString: responseString)! as! [Country]
                    completion(.success(countries))
                case .error(let error):
                    print("Error message " + error.localizedDescription)
                    completion(.failure(error.localizedDescription))
                }
        }
        
    }
    
    
}

