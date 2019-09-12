//
//  FindingCarDetialVC.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/1/11.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit


let ZYTopViewH:CGFloat = 350.0

class FindingCarDetialVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var topsView = UIImageView()
    let findDetialTab = UITableView()
    var paparametersArr:[String] = ["上市时间:","排量(cc):","最大功率(kw/rpm)","油箱容积(L):","制动方式:","适用地形:"]
    var paramsDetialArr:[String] = ["名称","年代","型号版本","类型","品牌","制造国","上市时间","生产状态","指导零售价","实际排量","缸数","冲程","每缸气门","配气结构","压缩比","最大功率","最大扭矩","冷却方式","供油方式","启动方式","油耗","环保标准","换挡配置","长x宽x高","座高","最小离地间隙","轴距","空车质量","整备质量","邮箱容积","最高车速","车轮数","轮胎品牌","前轮规格","后轮规格","制动系统","避震系统","行程特点","仪表形式","行车灯具","手把特点","电池规格","其他"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavtransparent()// 导航栏透明
        stepview()
        
        
    }
    
    // 导航栏透明
    func setNavtransparent() {
        // 1、设置视图背景颜色
        self.view.backgroundColor = UIColor.white
        // 2、设置导航栏标题属性：设置标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        // 3、设置导航栏前景色：设置item指示色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 4、设置导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = true
        // 5、设置导航栏背景图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // 6、设置导航栏阴影图片
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
    // 1,车图片 2，价格 3，生产制造商 4，功率 5，采用技术标准
    
    func stepview() {
        //
        findDetialTab.frame = CGRect(x: 0, y: 0, width:SCREEN_W , height: SCREEN_H-44)
        findDetialTab.delegate = self
        findDetialTab.dataSource = self
        findDetialTab.register(UITableViewCell.self, forCellReuseIdentifier: "findingCarDetialVC")
        self.view.addSubview(findDetialTab)
        
        findDetialTab.contentInset = UIEdgeInsetsMake(ZYTopViewH * 0.5, 0, 0, 0)
        let topView = UIImageView()
        topView.image  = UIImage(named: "F800GTss")
        topView.frame = CGRect(x: 0, y: -ZYTopViewH, width: 375, height: ZYTopViewH)
        topView.contentMode = UIViewContentMode.scaleAspectFill
        self.findDetialTab.insertSubview(topView, at: 0)
        
        self.topsView = topView
    }
    
    // 
    func  priceView() {
      //
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "findingCarDetialVC", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "findingCarDetialVC"
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let offSetH = -ZYTopViewH * 0.5 - offSetY
        if offSetH < 0 {
            return
        }
        
        var framee = self.topsView.frame
        framee.size.height = ZYTopViewH + offSetH
        self.topsView.frame = framee
    }
    
    // 滚动后恢复 Nav 颜色
    
    

   

}




