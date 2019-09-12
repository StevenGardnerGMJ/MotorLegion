//
//  LoginViewController.swift
//  MotorLegion
//
//  Created by gemaojing on 2017/11/8.
//  Copyright © 2017年 葛茂菁. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let textField0 = UITextField() // 手机号
    let textField1 = UITextField() // 密码
    let loginbgLabel = UILabel()  // 滑动登录
    
    let slidImage = UIImageView(image: #imageLiteral(resourceName: "btn1"))//UIImageView(image: UIImage(named: "btn1"))
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label0 = UILabel()
        label0.text = "登录"
        label0.font = UIFont.systemFont(ofSize: 28)
        label0.textColor = defaultTextBlack51Color
        view.addSubview(label0)
        
        let regButton = UIButton(type: .custom)
        regButton.addTarget(self, action: #selector(regButtonSelect), for: .touchUpInside)
        regButton.setTitle("注册", for: .normal)
        regButton.titleLabel?.textAlignment = .right
        regButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        regButton.setTitleColor(defaultPurpleColor, for: .normal)
        view.addSubview(regButton)
        
        let label1 = UILabel()
        label1.text = "+86"
        label1.font = UIFont.systemFont(ofSize: 18)
        label1.textColor = defaultTextBlack51Color
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "登录密码"
        label2.font = UIFont.systemFont(ofSize: 18)
        label2.textColor = defaultTextBlack51Color
        view.addSubview(label2)
        
        textField0.showFinishButtonTitle(title: "完成")
        textField1.showFinishButtonTitle(title: "完成")
        textField0.font = UIFont.systemFont(ofSize: 18)
        textField1.font = UIFont.systemFont(ofSize: 18)
        textField0.placeholder = "手机号/邮箱账户"
        textField1.placeholder = "6-20位字母数字"
        textField0.clearButtonMode = .always
        textField1.clearButtonMode = .always
        textField0.keyboardType = .numberPad
        textField1.isSecureTextEntry = true
        self.view.addSubview(textField0)
        self.view.addSubview(textField1)
        
        textField0.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        
        
        
        let forgetPasswordBtn = UIButton(type: .custom)
        forgetPasswordBtn.addTarget(self, action: #selector(forgetPasswordBtnSelect), for: .touchUpInside)
        forgetPasswordBtn.setTitle("忘记密码？", for: .normal)
        forgetPasswordBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        forgetPasswordBtn.setTitleColor(defaultTextBlack51Color, for: .normal)
        view.addSubview(forgetPasswordBtn)
        
        loginbgLabel.center = self.view.center
        loginbgLabel.bounds = CGRect(x: 0, y: 0, width: 250*SCREEN_W/375, height: 44)
        loginbgLabel.text = "滑动登录"
        loginbgLabel.textColor = defaultPurpleColor
        loginbgLabel.font = UIFont.systemFont(ofSize: 16)
        loginbgLabel.layer.borderColor = defaultPurpleColor.cgColor
        loginbgLabel.layer.borderWidth = 1
        loginbgLabel.layer.cornerRadius = 22
        loginbgLabel.textAlignment = .center
        loginbgLabel.isUserInteractionEnabled = true
        view.addSubview(loginbgLabel)
        
        let  pangs = UIPanGestureRecognizer(target: self, action: #selector(panGesSelect))
        slidImage.addGestureRecognizer(pangs)
        slidImage.isUserInteractionEnabled = true
        slidImage.frame = CGRect(x: 5, y: 3, width: 50, height: 38)
        loginbgLabel.addSubview(slidImage)
        
        let label3 = UILabel()
        label3.textColor = defaultTextlightColor179
        label3.text = "使用XXXX, 就表示您同意XXXX的"
        label3.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(label3)
        
        let roleBtn = UIButton(type: .custom)
        roleBtn.setTitleColor(defaultPurpleColor, for: .normal)
        roleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        roleBtn.addTarget(self, action: #selector(roleBtnSelect), for: .touchUpInside)
        roleBtn.setTitle("使用条款", for: .normal)
        view.addSubview(roleBtn)
        
        // 
        
    
    }
    // 电话号码位数判断 11 位
    func textFieldDidChange(textField:UITextField)  {
        guard let text = textField.text else {return}//text为空返回
        if text.characters.count > 11 {
            let index = text.index(text.startIndex, offsetBy: 11)
            textField.text = text.substring(to: index)
        }
    }
    
    func regButtonSelect(){
        let vc = Regist0ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func panGesSelect(pan:UIPanGestureRecognizer) {
        let point  = pan.translation(in: loginbgLabel)
        if point.x < 0 {
            return
        }
        if slidImage.frame.minX >= 250*SCREEN_W/375-50-5 {
            slidImage.frame.origin.x = 250*SCREEN_W/375-50-5
        } else {
            slidImage.center.x += point.x
        }
        pan.setTranslation(.zero, in: loginbgLabel)
        if pan.state == .ended {
            if slidImage.frame.minX >= 250*SCREEN_W/375-50-5 {
                logingIn()
            }
        } else {
            loginButtonBack()
        }
        
    }
    
    func loginButtonBack() {
        UIView.animate(withDuration: 0.3) {
            self.slidImage.frame.origin.x = 5
        }
    }
    
    func forgetPasswordBtnSelect() {
        guard let phone = textField0.text else {
            HUD.manager.showTitle(string: "请输入正确的手机号", missTime: 1)
            loginButtonBack()
            return
        }
        if phone.characters.count != 11 {
            HUD.manager.showTitle(string: "请输入正确的手机号", missTime: 1)
        }
        
        
        
    }
    
    func roleBtnSelect() {
        
    }
    func logingIn() {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
}
