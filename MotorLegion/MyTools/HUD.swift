//
//  HUD.swift
//  LongGuangHui
//
//  Created by lyl on 16/10/8.
//  Copyright © 2016年 miruo. All rights reserved.
//

import UIKit


typealias HUDFinishBlock = () -> Void


class HUD: NSObject {


    /**< 字号 >*/
    var font = UIFont.systemFont(ofSize: 11)
    var textColor = UIColor.white
    var bgColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
    var showtime = 1.5


    let windowWidth = UIScreen.main.bounds.width
    let windowHeight = UIScreen.main.bounds.height

    private var block: HUDFinishBlock?

    private lazy var hudView: HUDView = {
        let view = HUDView()
        return view
    }()


    private lazy var hudWhiteView: HUDWhiteView = {
        let view = HUDWhiteView()
        return view
    }()


    static let manager = HUD()
    private override init() {}

    /**< 显示 >*/
    private func show() {
        hudView.removeFromSuperview()
        hudView.alpha = 0.1

        let window = UIApplication.shared.keyWindow
        hudView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        window?.addSubview(hudView)
        UIView.animate(withDuration: 0.1) {
            self.hudView.alpha = 1
        }
    }

    /**< 只显示, 标题 >*/
    func showTitle(string: String) {
        show()
        hudView.showTitle(string: string)
    }
    /**< 显示hud>*/
    func showHUD() {
        show()
        hudView.showHUD()
    }
    /**< 显示自定义图片>*/
    func showImage(image: UIImage) {
        show()
        hudView.showImage(image: image)
    }
    /**< 显示，标题，自定义图片>*/
    func showTitleWithImage(string: String, image: UIImage) {
        show()
        hudView.shwoTitleWithImage(string: string, image: image)
    }
    /**< 显示，标题，hud>*/
    func showHUDWihtTitle(string: String) {
        show()
        hudView.shwoHUDWihtTitle(string: string)
    }

    func showTitle(string: String, missTime: Int) {
        show()
        hudView.showTitle(string: string)
        self.missTime(time: missTime)
    }
    func showHUD(missTime: Int) {
        show()
        hudView.showHUD()
        self.missTime(time: missTime)
    }
    func showImage(image: UIImage, missTime: Int) {
        show()
        hudView.showImage(image: image)
        self.missTime(time: missTime)
    }
    func showTitleWithImage(string: String, image: UIImage, missTime: Int) {
        show()
        hudView.shwoTitleWithImage(string: string, image: image)
        self.missTime(time: missTime)
    }
    func showHUDWihtTitle(string: String, missTime: Int) {
        show()
        hudView.shwoHUDWihtTitle(string: string)
        self.missTime(time: missTime)
    }

    func showTitle(string: String, missTime: Int, block: @escaping HUDFinishBlock) {
        show()
        hudView.showTitle(string: string)
        self.missTime(time: missTime)
        self.block = block
    }
    func showHUD(missTime: Int, block: @escaping HUDFinishBlock) {
        show()
        hudView.showHUD()
        self.missTime(time: missTime)
        self.block = block
    }
    func showImage(image: UIImage, missTime: Int, block: @escaping HUDFinishBlock) {
        show()
        hudView.showImage(image: image)
        self.missTime(time: missTime)
        self.block = block
    }
    func showTitleWithImage(string: String, image: UIImage, missTime: Int, block: @escaping HUDFinishBlock) {
        show()
        hudView.shwoTitleWithImage(string: string, image: image)
        self.missTime(time: missTime)
        self.block = block
    }
    func showHUDWihtTitle(string: String, missTime: Int, block: @escaping HUDFinishBlock) {
        show()
        hudView.shwoHUDWihtTitle(string: string)
        self.missTime(time: missTime)
        self.block = block
    }

    private func missTime(time: Int) {

        let dalay = DispatchTime.now() + DispatchTimeInterval.seconds(time)
        DispatchQueue.main.asyncAfter(deadline: dalay) {
            self.dismiss()
        }

    }



    func timeDismiss() {
        dismiss()
    }

    /**< 只显示, 标题 >*/
    func showWhiteView(title: String?, image: UIImage?, block: @escaping HUDFinishBlock) {

        hudWhiteView.removeFromSuperview()
        hudWhiteView.alpha = 0.1

        let window = UIApplication.shared.keyWindow
        hudWhiteView.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight)
        window?.addSubview(hudWhiteView)
        UIView.animate(withDuration: 0.1) {
            self.hudWhiteView.alpha = 1
        }

        hudWhiteView.show(title: title, image: image)

        let dalay = DispatchTime.now() + DispatchTimeInterval.seconds(2)
        DispatchQueue.main.asyncAfter(deadline: dalay) {
            self.hudWhiteView.alpha = 0
            self.hudWhiteView.removeFromSuperview()
            block()
        }

    }




    public func dismiss() {

        self.hudView.alpha = 0
        self.hudView.removeFromSuperview()
        if let block = self.block {
            block()
        }
    }

}

enum hudType {
    case text
    case image
    case hud
    case hudAndText
    case imageAndText
}



class HUDView: UIView {



    var type: hudType  = .text

    private lazy var grayView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var hud: UIActivityIndicatorView = {
        let hud = UIActivityIndicatorView()
        return hud
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = self.textColor
        label.textAlignment = .center
        label.font = self.font
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private var font = HUD.manager.font
    private var textColor = HUD.manager.textColor
    private var bgColor = HUD.manager.bgColor

    private let garyViewWidth = 80

    override init(frame: CGRect) {
        super.init(frame: frame)

        grayView.backgroundColor = bgColor
        grayView.layer.cornerRadius = 5
        grayView.clipsToBounds = true
        self.addSubview(grayView)

    }

    func showTitle(string: String) {
        show(title: string, image: nil, type: .text)
    }
    func showHUD() {
        show(title: nil, image: nil, type: .hud)
    }
    func showImage(image: UIImage) {
        show(title: nil, image: image, type: .image)
    }
    func shwoTitleWithImage(string: String, image: UIImage) {
        show(title: string, image: image, type: .imageAndText)
    }
    func shwoHUDWihtTitle(string: String) {
        show(title: string, image: nil, type: .hudAndText)
    }

    private func show(title: String?, image: UIImage?, type: hudType) {

        grayView.bounds = CGRect(x: 0, y: 0, width: garyViewWidth, height: garyViewWidth)
        grayView.center = self.center

        for v in grayView.subviews {
            v.removeFromSuperview()
        }

        switch type {
        case .text:

            if  let title = title {
                let size = title.boundingRect(with: CGSize(width: garyViewWidth*2, height: 2000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: self.font], context: nil).size

                grayView.bounds = CGRect(x: 0, y: 0, width: size.width + 20, height: size.height + 20)
            }


            titleLabel.frame = CGRect(x: 5, y: 5, width: grayView.bounds.width - 10, height: grayView.bounds.height - 10)
            titleLabel.text = title
            grayView.addSubview(titleLabel)
            break
        case .image:
            grayView.addSubview(imageView)
            imageView.frame = CGRect(x: 20, y: 20, width: grayView.bounds.width - 40, height: grayView.bounds.height - 40)
            imageView.image = image
            break
        case .hud:

            grayView.addSubview(hud)
            hud.frame = CGRect(x: 20, y: 20, width: grayView.bounds.width - 40, height: grayView.bounds.height - 40)
            hud.startAnimating()
            break
        case .imageAndText:

            grayView.addSubview(imageView)
            grayView.addSubview(titleLabel)
            imageView.frame = CGRect(x: 20, y: 20, width: grayView.bounds.width - 40, height: grayView.bounds.width - 40)
            imageView.image = image
            titleLabel.frame = CGRect(x: 5, y: grayView.bounds.height - 20, width: grayView.bounds.width - 10, height: 20)
            titleLabel.text = title
            break
        case .hudAndText:

            grayView.addSubview(hud)
            grayView.addSubview(titleLabel)
            hud.frame = CGRect(x: 20, y: 20, width: grayView.bounds.width - 40, height: grayView.bounds.width - 40)
            hud.startAnimating()
            titleLabel.frame = CGRect(x: 5, y: grayView.bounds.height - 20, width: grayView.bounds.width - 10, height: 20)
            titleLabel.text = title
            break
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

class HUDWhiteView: UIView {

    private lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    private lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = defaultTextBlack51Color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        bgImageView.image = UIImage(named: "grayshadow")?.stretchableImage(withLeftCapWidth: 25, topCapHeight: 25)
        imageView.contentMode = .center
        self.addSubview(bgImageView)

        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 5
        bgView.clipsToBounds = true
        bgImageView.addSubview(bgView)

        bgView.addSubview(titleLabel)
        bgView.addSubview(imageView)

    }

    func show(title: String?, image: UIImage?) {

        bgImageView.bounds = CGRect(x: 0, y: 0, width: 100, height: 85)
        bgImageView.center = self.center

        bgView.frame = CGRect(x: 5, y: 5, width: bgImageView.bounds.width - 10, height: bgImageView.bounds.height - 10)

        imageView.frame = CGRect(x: 20, y: 15, width: bgView.bounds.width - 40, height: bgView.bounds.width - 60)
        titleLabel.frame = CGRect(x: 5, y: bgView.bounds.height - 25, width: bgView.bounds.width - 10, height: 20)
        imageView.image = image
        titleLabel.text = title
    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}



