//
//  ADvertisCell.swift
//  MotorLegion
//
//  Created by gemaojing on 2016/11/10.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class ADvertisCell: UITableViewCell {
    
    /// 广告cell 默认高度不低于80（其中图片高60 距离上边缘下边缘各10）
    
    var  imageSortV = UIImageView()
    var  labTitle = UILabel()
    var  labSmall = UILabel()
    var  btnTagS  = UIButton()
    var  line_v   = UIView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // code
        contentView.addSubview(imageSortV)
        contentView.addSubview(labTitle)
        contentView.addSubview(labSmall)
        contentView.addSubview(btnTagS)
        contentView.addSubview(line_v)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        let toTop_H:CGFloat = 5
        // code
        imageSortV.frame = CGRect(x:SCREEN_W - 65, y: toTop_H, width: 60, height: 60)
        labTitle.frame = CGRect(x: 10, y: toTop_H, width: SCREEN_W - (10+60+10), height: 60)
        labTitle.numberOfLines = 2
        
        btnTagS.frame = CGRect(x: 10, y: self.frame.height - 10 - 11, width: 20, height: 11)
        btnTagS.setTitle("广告", for: UIControlState.normal)
        btnTagS.setTitleColor(UIColor.black, for: UIControlState.normal)
        btnTagS.titleLabel?.font = UIFont.systemFont(ofSize: 9.0)
        btnTagS.layer.cornerRadius = 3
        btnTagS.layer.borderWidth = 1
        btnTagS.layer.borderColor = UIColor.lightGray.cgColor
        
        labSmall.frame = CGRect(x: btnTagS.frame.maxX+10, y: btnTagS.frame.origin.y, width: SCREEN_W - (60+10+btnTagS.frame.maxX+10), height: 11)
        labSmall.textColor = UIColor.lightGray
        labSmall.font = UIFont.systemFont(ofSize: 9)
        labSmall.text = "BMW专属广告"
        
        line_v.frame = CGRect(x: 10, y: self.frame.height-1, width: SCREEN_W-20, height: 1)
        line_v.backgroundColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1)
        
        
    }
    
    
    
}
