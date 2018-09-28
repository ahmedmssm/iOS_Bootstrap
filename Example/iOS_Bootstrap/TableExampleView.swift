//
//  TableExampleView.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 6/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iOS_Bootstrap

class TableExampleView: BaseTableView<Country>, BaseTableViewDelegates {
    
    @IBOutlet weak var tableview: UITableView!
    private var controller : TableController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Mock a network delay with 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.controller.getWorldCountries()
        }
    }
    
    override func initUI() {
        let refreshControl = UIRefreshControl()
        getTableViewAdapter.configurePullToRefresh(refreshControl: refreshControl)
        getTableViewDataSource.removeAll()
    }
    
    override func initTableViewAdapterConfiguraton() {
        getTableViewAdapter.configureTableWithXibCell(tableView: tableview, nibClass: TableViewCell.self, delegate: self)
    }
    
    override func initController() { controller = TableController(view: self) }

    func configureCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.labelCountryName.text = getTableViewDataSource [indexPath.row].countryName
        cell.labelCapitalName.text = getTableViewDataSource [indexPath.row].capital
        return cell
    }
    
    func didGetCountries(countries : [Country]) {
        getTableViewAdapter.reloadTable(pageItems: countries)
    }
    
    func didFailToGetCountries(error : String) {
        // Do any thing with your error
        Log.error("Error " + error)
    }
    
}

