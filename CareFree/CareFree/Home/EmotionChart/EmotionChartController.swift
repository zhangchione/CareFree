//
//  EmotionChartController.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import DNSPageView

class EmotionChartController: UIViewController {

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
    // 右边分享按钮
    private lazy var RightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "home_share"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configPage()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "情绪报表"
        
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView:RightBarButton)
        
    }
    
    func configPage() {
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.init(r: 96, g: 114, b: 255)
        style.titleColor = UIColor.black
        style.bottomLineHeight = 0
        style.bottomLineColor = UIColor.init(r: 96, g: 114, b: 255)
        style.titleViewBackgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        
        style.titleFont = UIFont.systemFont(ofSize: 18)
        
        let titles = ["日","周","月","年"]
        let viewControllers:[UIViewController] = [DayEmotionController(),WeekEmotionController(),MouthEmotionController(),YearEmotionController()]
        for vc in viewControllers{
            self.addChild(vc)
            
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: 88, width: CFWidth, height: CFHeight-navigationBarHeight-44), style: style, titles: titles, childViewControllers: viewControllers)
        
        pageView.titleView.frame = CGRect(x: CFWidth/6, y: 0, width: 2 * CFWidth/3 , height: 44)
        view.addSubview(pageView)
    }

}

extension EmotionChartController {
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}
