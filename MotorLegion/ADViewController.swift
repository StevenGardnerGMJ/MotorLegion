//
//  ADViewController.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class ADViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    let cell_H:CGFloat = 80
    
    var  tableview_AD = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        config() // table界面
        dissmisBtnConfig()// 取消按钮
    }
    
    func config() {
        tableview_AD.frame = CGRect(x: 0, y: 44, width: SCREEN_W, height: SCREEN_H-49)
        tableview_AD.register(ADvertisCell.self, forCellReuseIdentifier: "tableviewcell_ad")
        tableview_AD.delegate = self
        tableview_AD.dataSource = self
        
        view.addSubview(tableview_AD)
        
    }
    
    func dissmisBtnConfig(){
        
        let dismisBtn = UIButton()
        dismisBtn.frame = CGRect(x: 10, y: 24, width: 24, height: 24)
        dismisBtn.setImage(UIImage.init(named: "close_icon"), for: UIControlState.normal)
        dismisBtn.setImage(UIImage.init(named: "close_icon_highlighted"), for: UIControlState.highlighted)
        dismisBtn.addTarget(self, action: #selector(dissmis), for: UIControlEvents.touchUpInside)
        view.addSubview(dismisBtn)
        let labtitle = UILabel()
        labtitle.frame = CGRect(x: 0, y: 34, width: 120, height: 24)
        labtitle.textAlignment = NSTextAlignment.center
        labtitle.center = CGPoint(x: SCREEN_W / 2, y: dismisBtn.center.y)
        labtitle.text = "广告系列"
        view.addSubview(labtitle)
    }
    
    
    
    // 退回
    func dissmis() {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell_ad", for: indexPath) as! ADvertisCell
//        cell.textLabel?.text = "tableviewcell_ad"
        cell.imageSortV.image = UIImage.init(named: "advideopic")
        cell.labTitle.text = "BMW(宝马)摩托RT1200X 生化危机限量版全球发售 "
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cell_H
    }
}





