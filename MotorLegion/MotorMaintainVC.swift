//
//  MotorMaintainVC.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class MotorMaintainVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
var table_Motomaintain = UITableView()
    var  motomArry = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        config()
        
    }
    func config() {
        table_Motomaintain.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H-44)
        table_Motomaintain.dataSource = self
        table_Motomaintain.delegate = self
        table_Motomaintain.register(UITableViewCell.self, forCellReuseIdentifier: "tablemotomaintain")
        view.addSubview(table_Motomaintain)
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablemotomaintain", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "table_Motomaintain"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 15
    }
    
}







