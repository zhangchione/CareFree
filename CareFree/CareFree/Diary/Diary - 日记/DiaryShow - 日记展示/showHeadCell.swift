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
        vi.backgroundColor = UIColor.white
        return vi
    }()
    
    lazy var day: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 44)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周四"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年7月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 13)
        label.textColor = UIColor.white
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
        label.textAlignment = .center
        return label
    }()
    
    lazy var centerView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15
        vi.layer.shadowColor = UIColor.init(r: 110, g: 127, b: 255,alpha: 0.26).cgColor
        vi.layer.shadowOffset = CGSize(width: 0, height: 2)
        vi.layer.shadowOpacity = 1
        vi.layer.shadowRadius = 7
        return vi
    }()
    
    lazy var todayLabel:UILabel = {
        let label = UILabel()
        label.text = "今天"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 18)
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
        label.font = UIFont(name: "PingFangSC-Semibold", size: 22)
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
    
    func updateUI(with data: DiaryTodayModel){
        self.emotionValue.text = "情绪值 " + String(data.mode)
        self.content.text = data.content
        day.text = (data.date as NSString).substring(to: 2)
        yearMouth.text = (data.date as NSString).substring(with: NSMakeRange(3,8))
        var weekText:String?
        
        switch (data.date as NSString).substring(from: 19) {
        case "Mon":
            weekText = "周一"
        case "Tue":
            weekText = "周二"
        case "Wed":
            weekText = "周三"
        case "Thu":
            weekText = "周四"
        case "Fri":
            weekText = "周五"
        case "Sat":
            weekText = "周六"
        default:
            weekText = "周日"
        }
        
        week.text = weekText
        
        if data.mode > 25 {
           self.rightView.backgroundColor = happyColor
        }else if data.mode < 25 && data.mode > 0 {
            self.rightView.backgroundColor = calmColor
        }else if data.mode < 0 && data.mode > -25 {
            self.rightView.backgroundColor = sadColor
        }else {
            self.rightView.backgroundColor = sadMoreColor
        }

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
        


        
        
        day.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(26)
            make.top.equalTo(self).offset(140)
            make.height.width.equalTo(60)
        }
        week.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5)
            make.top.equalTo(self).offset(150)
            make.height.equalTo(20)
            make.width.equalTo(35)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5)
            make.top.equalTo(week.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(90)
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
            make.width.equalTo(90)
            make.height.equalTo(25)
        }
        
        centerView.snp.makeConstraints{(make) in
            make.top.equalTo(day.snp.bottom).offset(30)
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
            make.top.equalTo(centerView.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(55)
        }
    }
    
    func configShadow(){
        
    }
    


}
