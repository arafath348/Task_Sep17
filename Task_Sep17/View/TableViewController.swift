//
//  TableViewController.swift
//  Task_Sep17
//
//  Created by L-156157182 on 17/09/18.
//

import UIKit
import Alamofire
import SDWebImage

class TableViewController: UITableViewController {
    

    private let cellId = "cellId"
    let refreshCntrol = UIRefreshControl()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshCntrol
        } else {
            tableView.addSubview(refreshCntrol)
        }
        
        // Configure Refresh Control
        refreshCntrol.addTarget(self, action: #selector(checkReachability), for: .valueChanged)
        tableView.allowsSelection = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)   // register cell name
        
        self.checkReachability()
    }
    
    // Check reachability and call api
    @objc func checkReachability(){
        if Connectivity.isConnectedToInternet {
            self.fetchAllData()
        }
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refreshCntrol.endRefreshing()
            }
        }
    }
    
    // MARK: - Fetch all data from api
    @objc func fetchAllData() {
        let api = ApiService()
        api.fetch(success: {
             [weak self] response in
            self?.title = self?.appDelegate.dataList[0].navBarTitle
            self?.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self?.refreshCntrol.endRefreshing()
            }
        })
    }
    
 
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows        
        return appDelegate.dataList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        let viewModel = self.appDelegate.dataList[indexPath.row]
        cell.setData(data: viewModel)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
