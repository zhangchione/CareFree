//
//  AlbumDetialController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/29.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import DNSPageView
import Photos
import Photos

class AlbumDetialController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
       // style.isTitleScrollEnable = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = happyColor
        style.titleColor = UIColor.gray
       // style.bottomLineColor = DominantColor
        style.bottomLineHeight = 0
//        style.contentViewBackgroundColor = UIColor.init(r: 247, g: 249, b: 254)
      //  style.coverViewBackgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        style.titleViewBackgroundColor = UIColor.init(r: 247, g: 249, b: 254)
//        style.TWidth = CFWidth
//        style.Ty = 0
//        style.Tx = 0
        style.titleFont = UIFont.systemFont(ofSize: 22)
        
        let titles = ["开心","平静","难过","压抑"]
        let viewControllers:[UIViewController] = [AlbumMoreViewController(),CalmViewController(),SadViewController(),SoSadViewController()]
        for vc in viewControllers{
            self.addChild(vc)

        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: 88, width: CFWidth, height: CFHeight-navigationBarHeight-44), style: style, titles: titles, childViewControllers: viewControllers)
        
       if  pageView.contentView.currentIndex == 1 {
            pageView.style.titleSelectedColor = calmColor
            print(pageView.contentView.currentIndex)
        }
        view.addSubview(pageView)
        configUI()
    }
    
    ///资源管理
    let rescouceManager = RescouceManager.share
    ///配置管理
    let rescoucceConfiguration = RescouceConfiguration.share
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.tintColor = UIColor.red
        return button
    }()
    // 右边AR展示按钮
    lazy var RightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ar_black"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(AR), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "相册"
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        //self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: RightButton)
        
    }
    @objc func AR(){
        print("进入AR展示")
        var albumVC: TKARViewController!
        let storB = UIStoryboard.init(name: "ARPanorama", bundle: nil)
        albumVC = storB.instantiateViewController(withIdentifier: "TKARViewController") as? TKARViewController
        DispatchQueue.global(qos: .userInteractive).sync {
            let manager = RescouceManager.share
            let imageManager = PHImageManager.default()
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            
            if manager.horizontalImages.count > 0 {
                for image in manager.horizontalImages {
                    manager.deleteHorizontalImage(image: image)
                }
            }
            if manager.verticalImages.count > 0 {
                for image in manager.verticalImages {
                    manager.deleteVerticalImage(image: image)
                }
            }
            
            manager.addVerticalImage(image: UIImage(named: "V_Image_00")!)
            manager.addVerticalImage(image: UIImage(named: "V_Image_01")!)
            manager.addVerticalImage(image: UIImage(named: "V_Image_02")!)
            manager.addVerticalImage(image: UIImage(named: "V_Image_03")!)
            manager.addVerticalImage(image: UIImage(named: "V_Image_04")!)
            manager.addVerticalImage(image: UIImage(named: "V_Image_05")!)
            
            manager.addHorizontalImage(image: UIImage(named: "H_Image_00")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_10")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_20")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_30")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_40")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_50")!)
            manager.addHorizontalImage(image: UIImage(named: "H_Image_60")!)
            
            manager.text = ""
            manager.textColor = "textColor_7"
        }
        
        DispatchQueue.global(qos: .background).async {
            var path=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            path+="/RescouceManager"
            NSKeyedArchiver.archiveRootObject(self.rescouceManager, toFile: path)
            var cPath=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            cPath+="/RescouceConfiguration"
            print("路径："+cPath)
            NSKeyedArchiver.archiveRootObject(self.rescoucceConfiguration, toFile: cPath)
        }
        albumVC.hero.isEnabled = true
        albumVC.view.hero.modifiers = [.fade, .scale(0.1)]
        albumVC.navigationItem.title = " "
        navigationController?.pushViewController(albumVC, animated: true)
    }

}
