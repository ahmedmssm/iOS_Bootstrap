//
//  MyViewController.swift
//  iOS_Bootstrap_Example
//
//  Created by Ahmad Mahmoud on 6/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//
// Ref : https://stackoverflow.com/questions/27960556/loading-an-overlay-when-running-long-tasks-in-ios
//

import UIKit
import iOS_Bootstrap

class MyViewController: BaseTableAdapterViewController<MyPresenter, MyViewControllerDelegator>, MyViewControllerDelegator, TableViewDelegates {
    
    @IBOutlet weak var switchLanguageButton: UIButton!
    @IBOutlet weak var usersTableVIew: UITableView!
    //
    private var dataSource : [User] = [User]()
    //
    private var mNavigator : NavigationCoordinator?
    var x : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Initialize Configuration
        Log.debug(GlobalKeys.getEnvironmentVariables.baseURL)
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set context
        AppDelegate.setContext(context: self)
        //
        Log.debug("ChangeLng".localized())
        switchLanguageButton.setTitle("ChangeLng".localized(), for: .normal)
    }
    
    func initUI() {
        mNavigator = self.navigator as? NavigationCoordinator
        getTableViewAdapter().configureTableWithXibCell(tableView: usersTableVIew, dataSource: dataSource, nibClass: UserCell.self, delegate: self)
    }
    
    // Button actions
    @IBAction func TestButton(_ sender: UIButton) {
        getPresenter.getUsers(pageNumber: 1)
    }
    //
    @IBAction func testNavigator(_ sender: UIButton) {
        // self.mNavigator?.startInitialView()

        let langMgr : MultiLanguageManager = MultiLanguageManager()
        if (langMgr.getCurrentAppLanguage() == Languages.Arabic.rawValue) {
            langMgr.switchAppLanguageInstantly(language: Languages.English)
        }
        else {
           langMgr.switchAppLanguageInstantly(language: Languages.Arabic)
        }
        
     //   let window = (UIApplication.shared.delegate as! AppDelegate).window
     //   let storyboard = UIStoryboard.getStoryboardWithName(Storyboards.main)
      //  window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "root")
        
     //   UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        //
        // Or
        //
        let windows = UIApplication.shared.windows
//        // Get the current app window without casting to app delegate
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.rootViewController = mNavigator?.navigationController
                window.addSubview(view)
           }
        }
        navigationController?.popViewController(animated: true)
    }
    // Tableview adapter functions
    func configureCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.userID.text = String(describing: dataSource [indexPath.row].id!)
        cell.firstName.text = dataSource [indexPath.row].first_name
        cell.lastName.text = dataSource [indexPath.row].last_name
        return cell
    }
    //
    func loadMore(forPage page: Int, updatedDataSource: [Any]) {
        self.dataSource = updatedDataSource as! [User]
        getPresenter.getUsers(pageNumber: page)
    }
 
    //
    func doNothing() {
        Log.info("I'm here...")
    }
    //
    func didGetFakeUsers(page: Page) {
        // Configure pagination parameters
         getTableViewAdapter().configurePaginationParameters(totalNumberOfItems: page.total!, itemsPerPage: page.perPage!)
        // Reload table with new page items only (Not the whole data source)
         getTableViewAdapter().reloadTable(pageItems: page.users!)
        // Update your data source
        self.dataSource.append(contentsOf: page.users!)
    }
    //
    func didFailToGetFakeUsers(error: String) {
        EZLoadingActivity.showWithDelay(error, disableUI: true, seconds: 3.0)
    }

}
