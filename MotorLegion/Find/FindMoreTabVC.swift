//
//  FindMoreTabVC.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/1/17.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit

class FindMoreTabVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "re")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "re", for: indexPath)
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "特斯拉 Model 3"
            cell.detailTextLabel?.text = "即将发布"
            cell.imageView?.image = UIImage(named: "images")
        case 1:
            cell.textLabel?.text = "特斯拉 Model S"
            cell.imageView?.image = UIImage(named: "images")
        case 2:
            cell.textLabel?.text = "特斯拉 Model X"
            cell.imageView?.image = UIImage(named: "images")
        default:
            print("其他情况")
        }


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let findDetialVC  = FindingCarDetialVC()
            self.navigationController?.pushViewController(findDetialVC, animated: true)
            
        default:
            print("其他")
        }
    }
    
    


}













