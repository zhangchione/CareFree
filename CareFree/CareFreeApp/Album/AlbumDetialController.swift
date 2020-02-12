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
        style.titleViewBackgroundColor = backColor
//        style.TWidth = CFWidth
//        style.Ty = 0
//        style.Tx = 0
        style.titleFont = UIFont.systemFont(ofSize: 22)
        
        let titles = ["开心","平静","难过","压抑"]
        
        var happyDatas = [ItemsModel]()
        var calmDatas = [ItemsModel]()
        var sadDatas = [ItemsModel]()
        var repressioneDatas = [ItemsModel]()
        
        let datas =  DataBase.shared.queryByMouth()
        
        for data in datas {
            var happydas = ItemsModel()
            var calmdas = ItemsModel()
            var saddas = ItemsModel()
            var repressionedas = ItemsModel()
            for da in data.data {
                let imgs = da.dayDiary.images.components(separatedBy: ",")
                if da.dayDiary.mode > 25 {
                    happydas.photos += imgs
                }else if da.dayDiary.mode <= 25 && da.dayDiary.mode > 0 {
                    calmdas.photos += imgs
                }else if da.dayDiary.mode <= 0 && da.dayDiary.mode > -25 {
                    saddas.photos += imgs
                }else{
                    repressionedas.photos += imgs
                }
                for das in da.nowDiary {
                    let imgs = das.images.components(separatedBy: ",")
                    if das.mode > 25 {
                        happydas.photos += imgs
                    }else if das.mode <= 25 && das.mode > 0 {
                        calmdas.photos += imgs
                    }else if das.mode <= 0 && das.mode > -25 {
                        saddas.photos += imgs
                    }else{
                        repressionedas.photos += imgs
                    }
                }
            }
            happydas.time = data.time
            calmdas.time = data.time
            saddas.time = data.time
            repressionedas.time = data.time
            happyDatas.append(happydas)
            calmDatas.append(calmdas)
            sadDatas.append(saddas)
            repressioneDatas.append(repressionedas)
        }
        let happyVC = AlbumItemsViewController(data: happyDatas)
        let sadVC = AlbumItemsViewController(data: sadDatas)
        let calmVC = AlbumItemsViewController(data: calmDatas)
        let repressionVC = AlbumItemsViewController(data: repressioneDatas)
        let viewControllers:[UIViewController] = [happyVC,calmVC,sadVC,repressionVC]
        for vc in viewControllers{
            self.addChild(vc)
        }
        let yy = isIphoneX ? 88.fit : 64.fit
        let pageView = DNSPageView(frame: CGRect(x: 0, y: CGFloat(yy), width: CFWidth, height: CFHeight-navigationBarHeight-44), style: style, titles: titles, childViewControllers: viewControllers)
        
       if  pageView.contentView.currentIndex == 1 {
            pageView.style.titleSelectedColor = calmColor
            print(pageView.contentView.currentIndex)
        }
        view.addSubview(pageView)
        configUI()
    }
    
//    ///资源管理
//    let rescouceManager = RescouceManager.share
//    ///配置管理
//    let rescoucceConfiguration = RescouceConfiguration.share
    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setTitle("←", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
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
        view.backgroundColor = backColor
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "相册"
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        //self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: RightButton)
        
    }
    @objc func AR(){
        print("进入AR展示")
    }

}
