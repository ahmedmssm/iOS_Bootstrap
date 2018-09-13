//
//  Connector.swift
//  iOS_Bootstrap
//
//  Created by Ahmad Mahmoud on 6/9/18.
//

import Foundation
import RxSwift

open class GenericConnector: NSObject, SessionProtocol {
    
    public typealias completionHandler<T> = (ConnectionResult<T>) -> ()
    public typealias completionHandlerWithErrorModel<T, E> = 
        (ConnectionResultWithGenericError<T, E>) -> ()
    //
    private final var sessionDelegate : SessionProtocol!
    
    public override init() {
        super.init()
        //
        sessionDelegate = self
    }
    
    open func getTokenRefreshService() -> Single<Response> {
        return Observable.empty().asSingle()
    }
    // Override this function to handle token response
    public func tokenDidRefresh(response: String) {
        let dictionary = ["response" : response]
        NotificationCenter.default.post(name: .newAuthenticationToken, object: nil, userInfo: dictionary)
    }
    //
    public func didFailedToRefreshToken() {
        NotificationCenter.default.post(name: .expiredToken, object: nil)
    }

}
