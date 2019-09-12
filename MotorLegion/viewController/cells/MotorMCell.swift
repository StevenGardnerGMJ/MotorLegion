//
//  MotorMCell.swift
//  MotorLegion
//
//  Created by gemaojing on 2016/11/10.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class MotorMCell: UITableViewCell {

    // 界面自定义 cell
    /*cell 高度动态计算 动态适应高度   collectCell 上下左右效果布局 实现瀑布流效果*/
    var imageSortV = UIImageView()
    var labTitle = UILabel()
    var labSmall = UILabel()
    var btnTagSmall = UIButton()
    var line_v = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageSortV)
        contentView.addSubview(labTitle)
        contentView.addSubview(labSmall)
        contentView.addSubview(btnTagSmall)
        contentView.addSubview(line_v)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        // code 
        
        
        
        
        
    }

    
    
    
}



