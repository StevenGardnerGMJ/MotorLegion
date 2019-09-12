//
//  FindingCell.swift
//  MotorLegion
//
//  Created by gemaojing on 2016/10/10.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit





// 主cell：数量最多
class FindingCell: UITableViewCell {

    var imageSort = UIImageView()
    var nameTitle = UILabel()
    var timeTag   = UILabel()
    var detialLab = UILabel()
    var tagBtn    = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageSort)
        contentView.addSubview(nameTitle)
        contentView.addSubview(timeTag)
        contentView.addSubview(detialLab)
        contentView.addSubview(tagBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        imageSort.frame = CGRect(x:10, y:5, width:60, height:60)
        nameTitle.frame = CGRect(x:imageSort.frame.maxX+10,y: 5, width:SCREEN_W-imageSort.frame.maxX-10, height:25)
        timeTag.frame = CGRect(x:10, y:imageSort.frame.maxY, width:60, height:15)
        detialLab.frame = CGRect(x:imageSort.frame.maxX+10, y:nameTitle.frame.maxY-3, width:SCREEN_W-imageSort.frame.maxX-30, height:30)
        
        timeTag.font = UIFont.systemFont(ofSize: 9.0)
        detialLab.font = UIFont.systemFont(ofSize: 11.0)
        detialLab.numberOfLines = 2
        
        tagBtn.frame = CGRect(x:imageSort.frame.maxX+10, y:timeTag.frame.origin.y, width:20, height:11)
        tagBtn.layer.borderColor = UIColor.orange.cgColor
        tagBtn.layer.borderWidth = 1.0
        tagBtn.layer.cornerRadius = 3.0
        tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9.0)
        tagBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    func  cornerBtn() -> UIButton{
        let btn  = UIButton()
        return btn
    }
    
    
}


// 热门品牌 cell 上Btn 点击方法
protocol FindCellADelegate {
    func click_btn()
}


class FindingCellA:UITableViewCell {
    
    var viewA = UIView()
    var viewB = UIView()
    var viewC = UIView()
    var viewD = UIView()
    var delegate_cellA:FindCellADelegate?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(viewA)
        contentView.addSubview(viewB)
        contentView.addSubview(viewC)
        contentView.addSubview(viewD)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let gap_front:CGFloat = 20
    let gap_back:CGFloat  = 20
    let gap_between:CGFloat = 40
    
    override func layoutSubviews() {
    btnUpImgDownLab(img: UIImage.init(named: "login")!, title: "个性推荐",addview: viewA)
    btnUpImgDownLab(img: UIImage.init(named: "login")!, title: "热销排行",addview: viewB)
    btnUpImgDownLab(img: UIImage.init(named: "login")!, title: "降价优惠",addview: viewC)
    btnUpImgDownLab(img: UIImage.init(named: "login")!, title: "我的收藏",addview: viewD)

    let img_w:CGFloat = (SCREEN_W - (gap_front+gap_back+gap_between*3)) / 4
        
    viewA.frame = CGRect(x: gap_front
        , y: 10, width: img_w, height: img_w+20)
    viewB.frame = CGRect(x: viewA.frame.maxX+gap_between, y: 10, width: img_w, height: img_w+20)
    viewC.frame = CGRect(x: viewB.frame.maxX+gap_between, y: 10, width: img_w, height: img_w+20)
    viewD.frame = CGRect(x: viewC.frame.maxX+gap_between, y: 10, width: img_w, height: img_w+20)
  
        
    }
    
    // 封装一下：上图下文字
    func btnUpImgDownLab(img:UIImage,title:String, addview:UIView) {
        
        let btnImg = UIButton()
        let btnLab = UIButton()
        
        let img_w = (SCREEN_W - (gap_front+gap_back+gap_between*3)) / 4
        
        btnImg.frame = CGRect(x: 0, y: 0, width: img_w, height: img_w)
        btnLab.frame = CGRect(x: 0, y: btnImg.frame.maxY, width: 80, height: 20)
        
        btnLab.center.x = btnImg.center.x
        
        btnImg.setImage(img, for: UIControlState.normal)
        btnLab.setTitle(title, for: UIControlState.normal)
        btnLab.setTitleColor(UIColor.black, for: UIControlState.normal)
        btnLab.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        btnImg.backgroundColor = UIColor.yellow
        btnImg.addTarget(self, action: #selector(clickbtn), for: UIControlEvents.touchUpInside)
        
        addview.addSubview(btnImg)
        addview.addSubview(btnLab)
    
    }
    
    
    func clickbtn(){
        print("cellA_btn")
       self.delegate_cellA?.click_btn()//执行协议func
    }
    
}

// 浏览历史 带scrollview
class FindingCellB:UITableViewCell {
    
    
    
}

// 筛选条件 4个 上图下文字
class FindingCellC:UITableViewCell {
    
}

// 图文字车品牌简介
class FindingcellD:UITableViewCell {
    var imageSort = UIImageView()
    var labTitle  = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageSort)
        contentView.addSubview(labTitle)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
       imageSort.frame = CGRect(x:10, y:5, width:60, height:60)
       labTitle.frame = CGRect(x:imageSort.frame.maxX+10,y: 10, width:SCREEN_W-imageSort.frame.maxX-10, height:30)
    }
    
    
    
    
    
}













