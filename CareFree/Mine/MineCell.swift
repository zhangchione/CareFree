//
//  MineCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/10.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class MineCell: UIView {

    lazy var userImg:UIImageView = {
       let vi = UIImageView()
        vi.backgroundColor=UIColor.red
        vi.cornerRadius = 45
        return vi
    }()
    lazy var userName:UILabel = {
       let label = UILabel()
        label.text = "Jeffrey"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 26)
        return label
    }()
    lazy var idView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 96, g: 114, b: 255)
        vi.cornerRadius = 14
        return vi
    }()
    lazy var id:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        label.text = "ID：4609"
        return label
    }()
    
    lazy var oneBackView : UIView = {
       let vi = UIView()
        return vi
    }()
    
    lazy var emotionView:UIView = {
       let vi = UIView()
        vi.cornerRadius = 25
        vi.backgroundColor = UIColor.gray
        return vi
    }()
    lazy var emotionLabel:UILabel  = {
       let label = UILabel ()
        label.textColor = UIColor.white
        label.text = "情绪值"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
        return label
    }()
    lazy var favIco:UIImageView = {
       let vi = UIImageView()
        vi.image = UIImage(named: "favor")
        return vi
    }()
    
    lazy var bottomView:UIView = {
        let vi = UIView()
        vi.cornerRadius = 8
        vi.backgroundColor = UIColor.white
        return vi
    }()
    lazy var topOneView:UIView  = {
       let vi = UIView()
        vi.cornerRadius = 20
        vi.backgroundColor = UIColor.init(r: 255, g: 135, b: 90)
        return vi
    }()
    lazy var topTwoView:UIView = {
        let vi = UIView()
        vi.cornerRadius = 8
        vi.backgroundColor = UIColor.init(r: 255, g: 135, b: 90)
        return vi
    }()
    
    lazy var emotionValue:UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.text = "31"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    lazy var lineView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        return vi
    }()
    lazy var pointLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Point"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    lazy var trashView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    
    lazy var setView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.cornerRadius = 25
        return vi
    }()
    lazy var setLabel:UILabel  = {
        let label = UILabel ()
        label.textColor = UIColor.black
        label.text = "设置"
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 14)
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
    
    func updateUI(){
        
    }
    
    func configUI(){
        
        addSubview(oneBackView)
        addSubview(userImg)
        addSubview(userName)
        addSubview(idView)
        idView.addSubview(id)
        addSubview(emotionView)
        emotionView.addSubview(oneBackView)
        emotionView.addSubview(emotionLabel)
        emotionView.addSubview(favIco)
        emotionView.addSubview(bottomView)
        emotionView.addSubview(topOneView)
        emotionView.addSubview(topTwoView)
        emotionView.addSubview(emotionValue)
        emotionView.addSubview(lineView)
        emotionView.addSubview(pointLabel)


        
        userImg.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(25)
            make.height.width.equalTo(90)
        }
        userName.snp.makeConstraints{(make) in
            make.left.equalTo(userImg.snp.right).offset(30)
            make.top.equalTo(self).offset(30)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        idView.snp.makeConstraints{(make) in
            make.left.equalTo(userImg.snp.right).offset(30)
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        id.snp.makeConstraints{(make) in
            make.left.equalTo(idView.snp.left).offset(9)
            make.top.equalTo(idView.snp.top).offset(0)
            make.width.equalTo(70)
            make.height.equalTo(30)
            
        }
        emotionView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(userImg.snp.bottom).offset(35)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        oneBackView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(userImg.snp.bottom).offset(35)
            make.width.equalTo(175)
            make.height.equalTo(215)
        }
        emotionLabel.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(20)
            make.top.equalTo(emotionView.snp.top).offset(30)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        favIco.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.centerY.equalTo(emotionLabel.snp.centerY)
            make.width.height.equalTo(20)
        }
        bottomView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.top.equalTo(emotionLabel.snp.bottom).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(105)
        }

        topTwoView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.bottom.equalTo(bottomView.snp.bottom).offset(0)
            make.width.equalTo(40)
            make.height.equalTo(60)
        }
        topOneView.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionLabel.snp.centerX)
            make.bottom.equalTo(topTwoView.snp.top).offset(30)
            make.width.equalTo(40)
            make.height.equalTo(50)
        }
        
        emotionValue.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.centerY.equalTo(bottomView.snp.centerY).offset(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-28)
            make.top.equalTo(emotionValue.snp.bottom).offset(3)
            make.width.equalTo(14)
            make.height.equalTo(1)
        }
        pointLabel.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-20)
            make.top.equalTo(lineView.snp.bottom).offset(3)
            make.width.equalTo(38)
            make.height.equalTo(20)
        }
        
        addSubview(trashView)
        
        trashView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(emotionView.snp.bottom).offset(20)
            make.width.equalTo(175)
            make.height.equalTo(175)
        }
        
        addSubview(setView)
        addSubview(setLabel)
        setView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(22)
            make.top.equalTo(trashView.snp.bottom).offset(20)
            make.width.equalTo(175)
            make.height.equalTo(185)
        }
        setLabel.snp.makeConstraints{(make) in
            make.left.equalTo(setView.snp.left).offset(20)
            make.top.equalTo(setView.snp.top).offset(30)
            make.width.equalTo(42)
            make.height.equalTo(22)
        }
        
    }
    func configShadow(){
        
    }
}
