//
//  setCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/11.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class setCell: UIView {

    lazy var topView:UIView = {
      let vi = UIView()
        //vi.backgroundColor = UIColor.red
        vi.cornerRadius  = 20
        return vi
    }()
    
    lazy var headOneLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "头像"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 18)
        return label
    }()

    
    lazy var userImg:UIImageView = {
       let vi = UIImageView()
         vi.backgroundColor  = UIColor.red
        vi.cornerRadius = 8
        return vi
    }()
    
    lazy var rightIco:UIImageView = {
        let vi = UIImageView()
        vi.backgroundColor  = UIColor.red
        vi.image = UIImage(named: "rightIco")
        return vi
    }()
    
    lazy var bottomView:UIView = {
        let vi = UIView()
       // vi.backgroundColor = UIColor.gray
        vi.cornerRadius  = 20
        return vi
    }()
    
    lazy var headTwoLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "昵称"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 18)
        return label
    }()
    
    lazy var userName:UILabel = {
        let label = UILabel()
        label.text = "Jeffrey"
        label.textAlignment = NSTextAlignment.right
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 16)
        label.textColor = UIColor.init(r: 180, g: 180, b: 180)
        return label
    }()
    
    lazy var rightIcoTwo:UIImageView = {
        let vi = UIImageView()
        vi.backgroundColor  = UIColor.red
        vi.image = UIImage(named: "rightIco")
        return vi
    }()
    
    
    init() {
        super.init(frame: .zero)
        configUI()
        configShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data:SetModel){
        if data.userImg == "" {
            userImg.isHidden = true
            userName.isHidden = true
        }
        headOneLabel.text = data.topHead
        headTwoLabel.text = data.bottomHead
    }
    func configUI(){
        addSubview(topView)
        addSubview(headOneLabel)
        addSubview(headTwoLabel)
        addSubview(userImg)
        addSubview(bottomView)
        addSubview(userName)
        addSubview(rightIco)
        addSubview(rightIcoTwo)
        
        topView.snp.makeConstraints{(make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(70)
        }

        headOneLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20)
            make.top.equalTo(self).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        rightIco.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(headOneLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(10)
        }
        userImg.snp.makeConstraints{(make) in
            make.right.equalTo(rightIco.snp.left).offset(-10)
            make.centerY.equalTo(headOneLabel.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        bottomView.snp.makeConstraints{(make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(70)
        }
        headTwoLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        rightIcoTwo.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(headTwoLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(10)
        }
        userName.snp.makeConstraints{(make) in
            make.right.equalTo(rightIcoTwo.snp.left).offset(-10)
            make.centerY.equalTo(headTwoLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }

        
    }
    func configShadow(){
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.layer.shadowColor = UIColor.init(red: 110, green: 127, blue: 255, alpha: 0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
    }
    
}
