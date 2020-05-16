//
//  AboutAppViewController.swift
//  CareFree
//
//  Created by 张驰 on 2020/2/3.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit
import SnapKit

class AboutViewController: UIViewController {

    
    // 左边返回按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "hone_icon_back"), for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
        button.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    
    
    lazy var appImg:UIImageView = {
       let vi = UIImageView()
        vi.image = UIImage(named: "icon-76")
        vi.cornerRadius = 10.fit
        vi.clipsToBounds = true
        return vi
    }()
    
    lazy var appName:UILabel = {
       let label = UILabel()
        label.text = "无忧日记"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.fit)
        return label
    }()
    
    lazy var appVersion:UILabel = {
       let label = UILabel()
        label.text = "1.1.0 (20200516)"
        label.font = UIFont.systemFont(ofSize: 14.fit)
                label.textAlignment = .center
        return label
    }()
    
    lazy var describe:UILabel = {
        let label = UILabel()
        label.text = "心情日记是一款基于情感分析的本地化日记类作品，它的运行环境为完全无网状态，用户可以不必担心自己的隐私会被泄露。希望您将生活中的美好点滴留住。"
        label.numberOfLines = 0
        
         return label
    }()
    
    lazy var openAddress: RestDaySelectedView = {
        let restDatView = RestDaySelectedView()
        restDatView.callback =  {

        }
       return restDatView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        setUI()
    }

    func configUI(){
        
        view.backgroundColor = backColor
        
    }
    
    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "关于"
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    

    @objc func back() {
         self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        view.addSubview(appImg)
        view.addSubview(appName)
        view.addSubview(appVersion)
        view.addSubview(describe)
        
        appImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
        make.top.equalTo(self.navigation.bar.snp.bottom).offset(30.fit)
            make.width.height.equalTo(80.fit)
        }
        appName.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appImg.snp.bottom).offset(30.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(80.fit)
        }
        appVersion.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appName.snp.bottom).offset(0.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(120.fit)
        }
        describe.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(200.fit)
            make.width.equalTo(CFWidth-40.fit)
        }
        
        openAddress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(27.fit)
            make.right.equalToSuperview().offset(-27.fit)
            make.top.equalTo(describe.snp.bottom).offset(90.fit)
            make.height.equalTo(40.fit)
        }
        
        
    }
}
