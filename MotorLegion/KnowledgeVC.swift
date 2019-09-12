//
//  KnowledgeVC.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit
// 例子 UIRefresh
class KnowledgeVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate {
    var tableview_know = UITableView()
    var refresh_know = UIRefreshControl()// 刷新控制
    var knowArray:Array = [String]()
    var tabviewFootview = UIView()
    var loadmoretext = UILabel()
    var loadmoreImgView = UIImageView()
    var stringEnd = String()
    var _oldOffset:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // ref
        refresh_know.tintColor = UIColor.orange
        loadrefreshview()
        refresh_know.addTarget(self, action: #selector(downData), for: UIControlEvents.valueChanged)
        refresh_know.attributedTitle = NSAttributedString(string: "陛下 正在刷新数据")
        
        tableview_know.addSubview(refresh_know)
        
        knowArray = ["热门","推荐","A","B","C","D","E","F"]
        stringEnd = "加载更多数据"
        // tab
        config_know()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        createtablefootview()

    }
    
    
    
    
    func createtablefootview() {
        
        self.tableview_know.tableFooterView = nil
        
        tabviewFootview.frame = CGRect(x: 0, y: 0, width:tableview_know.bounds.size.width, height: 30)
        loadmoretext.frame = CGRect(x: 0, y: 0, width: tableview_know.bounds.size.width, height: 24)
   // 计算文字长度
//        let rect = getTextRectSize(text: stringEnd , font: UIFont.systemFont(ofSize: 15), size: CGSize.init(width: 1000, height: 1000))
        loadmoreImgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        loadmoreImgView.center.x = SCREEN_W/2
        loadmoreImgView.center.y = 10
        
        loadmoretext.center = CGPoint(x: SCREEN_W/2, y: loadmoretext.center.y+20)
        
        loadmoreImgView.image = UIImage.gifWithName(name: "juhua")
        loadmoretext.text = "载入更多zzz"
        loadmoretext.font = UIFont.systemFont(ofSize: 15.0)
        loadmoretext.textAlignment = NSTextAlignment.center
        tabviewFootview.addSubview(loadmoretext)
        tabviewFootview.addSubview(loadmoreImgView)
        self.tableview_know.tableFooterView = tabviewFootview
        
    }
    
    
    
    
    // 已经滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > _oldOffset {
            // 大于 当前说明向上滑动
//            createtablefootview() // 加上
            
            if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height+10 {
                            loadmoretext.text = stringEnd
                        } else {
                            loadmoretext.text = "载入更多zzz"
                        }
            
        } else {
            // 向下滑动
            self.tableview_know.tableFooterView = nil
        }
        

    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        loadmoretext.text = "上拉加载更多"
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 10) {
            loadrefreshview()
            self.tableview_know.reloadData()
        }
    }

    func downData () {
        print("下拉刷新xia")
        knowArray = ["热门","推荐","A","B","C","D","E","F"]
        tableview_know.reloadData()
        
    }
    func loadrefreshview(){
        print("loadmore-网络请求也在此处")
        
        let arrayNew =  ["热门","推荐","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        // 判断数据数组是否相同
        if knowArray == arrayNew {
            stringEnd = "陛下没有更多数据了"
        } else {
            knowArray = arrayNew
        }
        
        
    }
    
    func config_know () {
        
        tableview_know.frame = CGRect(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H-44)
        tableview_know.delegate = self
        tableview_know.dataSource = self
        tableview_know.register(UITableViewCell.self, forCellReuseIdentifier: "tableviewknow")
        view.addSubview(tableview_know)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knowArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewknow", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "tableviewknow"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refresh_know.endRefreshing()
    }
    
    // 获取文字长宽高
    func getTextRectSize(text:String,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
    }
    
    
    
    

} // 尾括号
