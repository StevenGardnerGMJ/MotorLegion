//
//  MLTabBarController.swift
//  MotorLegion
//
//  Created by gemaojing on 16/9/18.
//  Copyright © 2016年 葛茂菁. All rights reserved.
//

import UIKit

class MLTabBarController: UITabBarController, MLTabBarDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let MLfindCon = FindingCarVC()
        let MLknowCon = KnowledgeVC()
        
        let MLmotoCon = MotorMaintainVC()
        let MLmyuserCon = MyUserInfomaVC()
        
        self.createChildVCwithVC(childVC: MLfindCon, title: "找车", image: "tab_moto", selectImage: "tab_motoselec")
        self.createChildVCwithVC(childVC: MLknowCon, title: "百科", image: "tab_baike", selectImage: "tab_baikeselec")
        
//        self.createChildVCwithVC(childVC: MLADCon, title: "广告", image: "post_normal", selectImage: "post_normal")
        
        self.createChildVCwithVC(childVC: MLmotoCon, title: "保养", image: "tab_baoyang", selectImage: "tab_baoyaselec")
        self.createChildVCwithVC(childVC: MLmyuserCon, title: "我的", image: "account_normal", selectImage: "account_highlight")
       
        
        let tabBarCenter = MLTabBar()
        tabBarCenter.delegatee = self
        tabBarCenter.shadowImage = UIImage()
        self.setValue(tabBarCenter, forKey: "tabBar")
        
    }
    
    //  点击中间按钮
    func tabBarDidClickPbtn(tabbar: MLTabBar) {
        // 调出广告页
        let ADTableview = ADViewController()
        self.present(ADTableview, animated: true, completion: nil)
        

//        // 调用相机功能
//        let alerController = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
//        let photoAction = UIAlertAction.init(title: "拍照", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
//            // do something ...
//            self.takePhoto()
//        }
//        let albumAction = UIAlertAction.init(title: "从相册选取", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
//            // do something ...
//            self.takeFromAlbum()
//        }
//        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
//        
//        alerController.addAction(photoAction)
//        alerController.addAction(albumAction)
//        alerController.addAction(cancelAction)
//        
//        self.present(alerController, animated:true, completion: nil)
        
    }

    
    
    // 封装子视图控制器
    func createChildVCwithVC(childVC:UIViewController,title:String,image:String,selectImage:String)
    {
       childVC.title = title
        var textAttrs:Dictionary<String,UIColor> = Dictionary()
        var selectTextAttrs:Dictionary<String,UIColor> = Dictionary()
        textAttrs[NSForegroundColorAttributeName] = UIColor.black
        selectTextAttrs[NSForegroundColorAttributeName] = UIColor.black
        childVC.tabBarItem.setTitleTextAttributes(textAttrs, for: UIControlState.normal)
        childVC.tabBarItem.setTitleTextAttributes(selectTextAttrs, for: UIControlState.selected)
        childVC.tabBarItem.image = UIImage.init(named: image)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let nav = MLNavController(rootViewController: childVC)
        self.addChildViewController(nav)
        
    }
    
    
    // 重写系统方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let count = self.tabBar.subviews.count
        
        for i in 0..<count {
            let child = self.tabBar.subviews[i] as UIView
            let classer:AnyClass = NSClassFromString("UITabBarButton")!
            if child.isKind(of: classer) {
               child.width = self.tabBar.width / CGFloat(count)
            }
        }
    }
    
    

    // 从照片选
    func takePhoto() {
        print("拍照照片")
        var sourceType = UIImagePickerControllerSourceType.camera
        
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
    
            sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = sourceType
        
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    // 从相册选
    func takeFromAlbum() {
        print("从相册选取")
        let  pickerImage = UIImagePickerController()
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            pickerImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pickerImage.mediaTypes = UIImagePickerController.availableMediaTypes(for: pickerImage.sourceType)!
            
        }
        pickerImage.delegate = self
        pickerImage.allowsEditing = true
        self.present(pickerImage, animated: true, completion: nil)

        
    }
    
    
    var imgView  = UIImageView()
    var img = UIImage()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("调用相机/相册后")
        img = info[UIImagePickerControllerEditedImage] as! UIImage
        imgView.image = img
        picker.dismiss(animated: true, completion: nil)
        
        let MLADCon   = ADViewController()
        imgView.frame = CGRect(x: 20, y: 40, width: 100, height: 100)
        MLADCon.view.addSubview(imgView)
        self.present(MLADCon, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}








