//
//  HumanReadableErrorHandler.swift
//  PassApp
//
//  Created by Ahmad Mahmoud on 4/14/18.
//  Copyright © 2018 Robustastudio. All rights reserved.
//

import iOS_Bootstrap

class HumanReadableErrorHandler: GenericErrorHandler {
    
    override func statusCodeError(_ statusCode: Int, errorBody: String?, request: URLRequest?, response: URLResponse?) -> String {
        //
        switch statusCode {
        case 401:
            errorMessage = "Not authorised ! " + errorBody!
        case 404:
            errorMessage = "Not found !"
        default:
            errorMessage = errorBody
            break
        }
        return errorMessage!
    }
    

    override func networkingError(_ error: LucidMoyaNetworkingError) -> String {
        return ""
    }
    
    override func moyaError(_ error: MoyaError) -> String {
        return ""
    }
    
}
