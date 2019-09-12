//
//  FindingCarVC.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit
import CoreData

// 采用 固定数据  (*^__^*) 嘻嘻…


class FindingCarVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,FindCellADelegate {

    let head_H:CGFloat = 20
    var tableview_find = UITableView()
    var sectionArr:[String] = ["热门","推荐","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        // nav back btn
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        congig()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func  congig ()  {
        tableview_find.frame = CGRect(x: 0, y: 0, width:SCREEN_W , height: SCREEN_H-44)
        tableview_find.delegate = self
        tableview_find.dataSource = self
        tableview_find.register(FindingCellA.self, forCellReuseIdentifier: "findcellA")
        tableview_find.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview_find.register(FindingCell.self, forCellReuseIdentifier: "findcell")
        tableview_find.register(FindingcellD.self, forCellReuseIdentifier: "findingcellD")
        tableview_find.sectionIndexBackgroundColor = UIColor.clear
        tableview_find.sectionIndexColor = UIColor.black
        
        self.view.addSubview(tableview_find)
    }
    
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "findcellA", for: indexPath) as! FindingCellA
            //        cell.textLabel?.text = "findcell"
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.delegate_cellA = self
            return cell
        } else  if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "findcell", for: indexPath) as! FindingCell
            //        cell.textLabel?.text = "findcell"
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.imageSort.image = UIImage.init(named: "m_findcar")
            cell.nameTitle.text = "美国小镇斯特吉斯欢迎您"
            cell.timeTag.text = "2016/11/09"
            cell.detialLab.text = "每年的全球机车俱乐部在此地举行有数十万人每年都会汇聚在此地共享摩托的盛宴这里有许多的机车队伍"
            cell.tagBtn.setTitle("说课", for: UIControlState.normal)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "findingcellD", for: indexPath) as! FindingcellD
            cell.imageSort.image = UIImage.init(named: "BMWLogo")
            cell.labTitle.text = "宝马R1200 RS"
            return cell
        }
    }
    // 3,实现协议方法
    func click_btn() {
        let toVC = ViewController()
        self.navigationController?.pushViewController(toVC, animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return head_H
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = hexStringTotoColor(hexString: "E9E9E9")//FCD957
        
        // header文字
        let titleLab = UILabel()
        
        titleLab.frame = CGRect(x: 10, y: 0, width: 100, height: head_H)
        
        titleLab.text = sectionArr[section]
        titleLab.textAlignment = NSTextAlignment.left
        titleLab.backgroundColor = UIColor.clear//hexStringTotoColor(hexString: "FCD957")
        headerView.addSubview(titleLab)
        return headerView
    }
    
    let img_w:CGFloat = (SCREEN_W - (20+20+40*3)) / 4
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return img_w+40
    }
    
    
    
    // 索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionArr
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var tempIndex:Int = 0
        for str in sectionArr {
            if str == title {
                return tempIndex - 1
            }
            tempIndex += 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击：\(indexPath.section) ，\(indexPath.row)")
        switch indexPath.section {
        case 3:
            let findDeVC = FindMoreTabVC()
            self.navigationController?.pushViewController(findDeVC, animated: true)
            
        default:
            print("其他界面")
        }
        
    }
    
    //
    func clickBtn_A() {
        print("clickBtn_A")
    }
    
    
    
    
    
    
    
    
    
}






















