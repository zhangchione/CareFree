//
//  showBodyCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class showBodyCell: UIView {

    lazy var backgruondView : UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 56, g: 213, b: 214)
        vi.layer.cornerRadius = 15
        return vi
    }()
    
    lazy var time:UILabel = {
        let label = UILabel()
        label.text = "12点17分"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.justified
        return label
    }()
    lazy var content:UILabel = {
        let label = UILabel()
        label.text = "泡在了实验室一天，果然充实的学习还是最幸福的"
        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
        label.textColor = UIColor.init(r: 127, g: 127, b: 127)
        label.numberOfLines = 0
        return label
    }()
    init() {
        super.init(frame: .zero)
        configUI()
        configShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        addSubview(backgruondView)
        addSubview(time)
        addSubview(content)
        
        backgruondView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.top.equalTo(self).offset(30)
            make.height.equalTo(150)
        }
        time.snp.makeConstraints{(make) in
            make.left.equalTo(backgruondView.snp.left).offset(20)
            make.top.equalTo(backgruondView.snp.top).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        content.snp.makeConstraints{(make) in
            make.left.equalTo(backgruondView.snp.left).offset(20)
            make.top.equalTo(time.snp.bottom).offset(20)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
    }
    func configShadow(){
        //self.backgroundColor = .cyan
        self.layer.cornerRadius = 20
        //self.layer.borderWidth = 1.0
        //self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor.init(red: 110, green: 127, blue: 255, alpha: 0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    func updateUI(){
        
    }
    
}
