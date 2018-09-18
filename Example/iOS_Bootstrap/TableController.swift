//
//  TableController.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 8/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import iOS_Bootstrap

 class TableController: BaseController<TableExampleView> {
    
    required override init(view: TableExampleView) {
        super.init(view: view)
    }

    func getWorldCountries() {
        API_Connector().getAllCountries (completion: { response in
            switch response {
            case .success(let countries):
                self.getView.didGetCountries(countries: countries)
                break
            case .failure(let errorMsg):
                self.getView.didFailToGetCountries(error: errorMsg)
                print("Error : " + errorMsg)
                break
            }
        })
    }
    
    func getError () {
        API_Connector().getErrorFromRequest (completion: { response in
            switch response {
            case .success( _):
                break
            case .failure(let errorMsg):
                print("Error : " + errorMsg)
                break
            }
        })
    }

 }
