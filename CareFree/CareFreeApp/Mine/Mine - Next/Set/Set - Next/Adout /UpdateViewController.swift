//
//  UpdateViewController.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    var describeText = ""
    var imageShow = false
    var update = -1
    var titleText = ""
    convenience init (text:String,imageShow:Bool,title:String){
        self.init()
        self.describeText = text
        self.imageShow = imageShow
        self.titleText = title
    }
    
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
    
    @objc func back() {
         self.navigationController?.popViewController(animated: true)
    }
    
    lazy var describe:UILabel = {
        let label = UILabel()
        label.text = descripeText
        label.numberOfLines = 0
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        label.alpha = 0.8
        
         return label
    }()
    
    lazy var image:UIImageView = {
       let vi = UIImageView()
        vi.image = UIImage(named: "wechat_img")
        vi.contentMode = .scaleAspectFit
        return vi
    }()
    
    lazy var thankLabel:UILabel = {
        let label = UILabel()
        label.text = "你的支持就是开发者最大的动力(*￣︶￣)"
        label.numberOfLines = 0
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14.fit)
        label.alpha = 0.8
        label.textAlignment = .center
         return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNav()
    }
    
    func configUI(){
        
        view.backgroundColor = .white
        
        view.addSubview(describe)
        let height = getTextHeight(textStr: descripeText, font: UIFont.init(name: "PingFangSC-Medium", size: 14.fit)!, width: CFWidth-54.fit)
        
        describe.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(10.fit)
            make.height.equalTo(height + 40.fit)
            make.width.equalTo(CFWidth-54.fit)
        }
        view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(describe.snp.bottom).offset(10.fit)
            make.height.equalTo(CFWidth-40.fit)
            make.width.equalTo(CFWidth-40.fit)
        }
        view.addSubview(thankLabel)
        thankLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(image.snp.bottom).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(CFWidth-40.fit)
        }
        
        self.describe.text = describeText
        if imageShow {
            image.alpha = 1
            thankLabel.alpha = 1
        }else {
            image.alpha = 0
            thankLabel.alpha = 0
        }
        if update == 4 {
            describe.snp.updateConstraints { (make) in
                make.height.equalTo(300.fit)
            }
        }
        if update == -10 {
            describe.snp.updateConstraints { (make) in
                make.height.equalTo(300.fit)
            }
        }
        
    }

    func configNav(){
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = titleText
        self.navigation.item.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
}
