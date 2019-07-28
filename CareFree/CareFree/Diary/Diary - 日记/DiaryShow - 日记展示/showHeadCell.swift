//
//  showHeadCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/7.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

// 添加按钮点击代理方法
protocol diaryShowDelegate:NSObjectProtocol {
    func diaryShowClick(mood:String)
}

class showHeadCell: UIView {
    
    var emotionLayer: CAGradientLayer!
    
    lazy var topView : UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 155, g: 121, b: 255)
        return vi
    }()
    
    lazy var headView : UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.cyan
        return vi
    }()
    
    lazy var day: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 44)
       // label.backgroundColor = UIColor.cyan
        //label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周四"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
       // label.backgroundColor = UIColor.yellow
        //label.backgroundColor = UIColor.green
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年7月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        //label.backgroundColor = UIColor.blue
        //label.backgroundColor = UIColor.blue
        return label
    }()
    
    lazy var rightView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 57, g: 210, b: 214)
        vi.layer.cornerRadius = 15
        return vi
    }()
    
    lazy var emotionValue:UILabel = {
       let label = UILabel()
            label.text = "情绪值 -12"
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var centerView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15
        
        return vi
    }()
    
    lazy var todayLabel:UILabel = {
        let label = UILabel()
        label.text = "今天"
        label.font = UIFont(name: "PingFangSC-Regular", size: 18)
        label.textColor = UIColor.black
        //label.backgroundColor = UIColor.red
        return label
    }()
    
    lazy var content:UILabel = {
       let label = UILabel()
        label.text = "  上班好累呀！好想休息，去浪迹天涯诶，上班真累，难过ing 😞 🙁！"
        label.font = UIFont(name: "PingFangSC-Regular", size: 16)
        label.textColor = UIColor.init(r: 127, g: 127, b: 127)
        label.numberOfLines = 0
       // label.backgroundColor = UIColor.blue
        label.textAlignment = NSTextAlignment.justified
        return label
    }()
    
    lazy var nowLabel:UILabel = {
        let label = UILabel()
        label.text = "此刻"
        label.font = UIFont(name: "PingFangSC-Regular", size: 22)
        label.textColor = UIColor.black
         //       label.backgroundColor = UIColor.blue
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
        addSubview(topView)
        addSubview(headView)
        addSubview(day)
        addSubview(week)
        addSubview(yearMouth)
        addSubview(rightView)
        rightView.addSubview(emotionValue)
        addSubview(centerView)
        centerView.addSubview(todayLabel)
        centerView.addSubview(content)
        addSubview(nowLabel)
        
        topView.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(-680)
            make.height.equalTo(680)
        }
        
        headView.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(270)
        }
        
        emotionLayer = CAGradientLayer()
        emotionLayer.frame = headView.bounds
        emotionLayer.colors = [UIColor.init(r: 155, g: 121, b: 255).cgColor,UIColor.init(r: 96, g: 114, b: 255).cgColor]
        //motionLayer.cornerRadius = 30
        headView.layer.addSublayer(emotionLayer)
        
        
        day.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(26)
            make.top.equalTo(self).offset(120)
            make.height.width.equalTo(60)
        }
        week.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5)
            make.top.equalTo(self).offset(130)
            make.height.equalTo(20)
            make.width.equalTo(35)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5)
            make.top.equalTo(week.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(70)
        }
        
        rightView.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(day.snp.centerY)
            make.width.equalTo(125)
            make.height.equalTo(35)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.centerY.equalTo(rightView.snp.centerY)
            make.centerX.equalTo(rightView.snp.centerX)
            make.width.equalTo(85)
            make.height.equalTo(25)
        }
        
        centerView.snp.makeConstraints{(make) in
            make.top.equalTo(day.snp.bottom).offset(50)
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.height.equalTo(150)
        }
        todayLabel.snp.makeConstraints{(make) in
            make.top.equalTo(centerView.snp.top).offset(15)
            make.left.equalTo(centerView.snp.left).offset(20)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        content.snp.makeConstraints{(make) in
            make.right.equalTo(centerView.snp.right).offset(-20)
            make.left.equalTo(centerView.snp.left).offset(20)
            make.top.equalTo(todayLabel.snp.bottom).offset(5)
            make.height.equalTo(80)
        }
        nowLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(25)
            make.top.equalTo(centerView.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.width.equalTo(55)
        }
    }
    
    func configShadow(){
        
    }
    
    func updateUI(){
        
    }

}
