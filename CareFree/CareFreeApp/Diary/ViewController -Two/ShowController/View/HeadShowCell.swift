//
//  HeadShowCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/1.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class HeadShowCell: UITableViewCell {
    
    var emotionLayer: CAGradientLayer!
    
    lazy var topView : UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.init(r: 155, g: 121, b: 255)
        return vi
    }()
    
    lazy var headView : UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.orange
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
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: config
extension HeadShowCell {
    func configUI(){
      //  self.backgroundColor = .cyan
        addSubview(topView)
        //addSubview(headView)
        addSubview(day)
        addSubview(week)
        addSubview(yearMouth)
        addSubview(rightView)
        rightView.addSubview(emotionValue)
        addSubview(centerView)
        centerView.addSubview(todayLabel)
        centerView.addSubview(content)
        
        topView.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-100.fit)
            make.height.equalTo(680)
        }
        
//        headView.snp.makeConstraints{(make) in
//            make.left.right.equalTo(self)
//            make.top.equalTo(self).offset(0)
//            make.height.equalTo(270)
//        }
        day.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(26.fit)
            make.top.equalTo(self).offset(20.fit)
            make.height.width.equalTo(60)
        }
        week.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5.fit)
            make.top.equalTo(self).offset(30.fit)
            make.height.equalTo(20)
            make.width.equalTo(35)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(5.fit)
            make.top.equalTo(week.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.width.equalTo(90)
        }
        
        rightView.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-30.fit)
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
            make.top.equalTo(day.snp.bottom).offset(30.fit)
            make.left.equalTo(self).offset(30.fit)
            make.right.equalTo(self).offset(-30.fit)
            make.height.equalTo(150)
        }
        todayLabel.snp.makeConstraints{(make) in
            make.top.equalTo(centerView.snp.top).offset(15.fit)
            make.left.equalTo(centerView.snp.left).offset(20.fit)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        content.snp.makeConstraints{(make) in
            make.right.equalTo(centerView.snp.right).offset(-20.fit)
            make.left.equalTo(centerView.snp.left).offset(20.fit)
            make.top.equalTo(todayLabel.snp.bottom).offset(5.fit)
            make.height.equalTo(80)
        }
    }
    func updateUI(with datas:CFDiaryModel) {
        let data = datas.dayDiary
        self.content.text = data.content
        let date = data.date
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "dd"
        let daytext = timeForMatter.string(from: date)
        timeForMatter.dateFormat = "yyyy年MM月"
        let yeartext = timeForMatter.string(from: date)
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "yyyy-MM-dd"
        let weektext = date.getWeekDay(dateTime: dateFmt.string(from: date))
        day.text = daytext
        yearMouth.text = yeartext
        week.text = weektext
        content.text = data.content
        emotionValue.text = "情绪值 \(datas.mode)"
    }
}
