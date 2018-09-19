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
    
    var dataList = [DataViewModel]()

    private let cellId = "cellId"
    let refreshCntrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshCntrol
        } else {
            tableView.addSubview(refreshCntrol)
        }
        
        // Configure Refresh Control
        refreshCntrol.addTarget(self, action: #selector(fetchAllData), for: .valueChanged)
        tableView.allowsSelection = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)   // register cell name
        self.fetchAllData()
    }
 
    // MARK: - Fetch all data from api
    @objc func fetchAllData() {
        let api = ApiService()
        api.fetch(success: {
            response in
            self.title = response["title"].string
            let rows = response["rows"]
            self.dataList = []
            for (_, value) in rows {
                if(!(value["title"].string == nil && value["description"].string == nil && value["imageHref"].string == nil)){
                    let dataViewModal = DataViewModel(data:DataModel(title: value["title"].string, description: value["description"].string, url:value["imageHref"].string))
                    self.dataList.append(dataViewModal)
                }
            }
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.refreshCntrol.endRefreshing()
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
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomTableViewCell
        let viewModel = self.dataList[indexPath.row]
        cell.setData(data: viewModel)
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
