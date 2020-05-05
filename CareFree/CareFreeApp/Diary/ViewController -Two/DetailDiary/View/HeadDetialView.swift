//
//  HeadDetialView.swift
//  CareFree
//
//  Created by 张驰 on 2020/5/4.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation

import UIKit

class HeadDetialView: UIView {
    
    
    lazy var topView : UIView = {
        let vi = UIView()

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
        label.font = UIFont(name: "PingFangSC-Semibold", size: 36.fit)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var week: UILabel = {
        let label = UILabel()
        label.text = "周四"
        label.font = UIFont(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var yearMouth: UILabel = {
        let label = UILabel()
        label.text = "2019年7月"
        label.font = UIFont(name: "PingFangSC-Regular", size: 14.fit)
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
        label.font = UIFont(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()

    

    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: config
extension HeadDetialView {
    func configUI(){
        addSubview(topView)
        addSubview(day)
        addSubview(week)
        addSubview(yearMouth)
        addSubview(rightView)
        addSubview(emotionValue)
        
        topView.snp.makeConstraints{(make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
        day.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(26.fit)
            make.bottom.equalTo(self).offset(-20.fit)
            make.height.equalTo(35.fit)
            make.width.equalTo(50.fit)
        }
        yearMouth.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(10.fit)
            make.bottom.equalTo(self).offset(-20.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(100.fit)
        }
        
        week.snp.makeConstraints{(make) in
            make.left.equalTo(day.snp.right).offset(10.fit)
            make.bottom.equalTo(self).offset(-40.fit)
            make.height.equalTo(15.fit)
            make.width.equalTo(80.fit)
        }
        rightView.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-20.fit)
            make.bottom.equalTo(self).offset(-20.fit)
            make.width.equalTo(125.fit)
            make.height.equalTo(35.fit)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.center.equalTo(rightView.snp.center)
            make.width.equalTo(90.fit)
            make.height.equalTo(30.fit)
        }
        
    }
    func updateUI(with data:DiaryModel) {
        DispatchQueue.main.async {
            switch data.mood {
            case 26 ... 50:
                self.topView.setLayerColors(happyGradientColor)
                self.rightView.backgroundColor = happyColor
            case 0 ... 25:
                self.topView.setLayerColors(calmGradientColor)
                self.rightView.backgroundColor = calmColor
            case -25 ... -1:
                self.topView.setLayerColors(sadGradientColor)
                self.rightView.backgroundColor = sadColor
            case -50 ... -26:
                self.topView.setLayerColors(repressioneGradientColor)
                self.rightView.backgroundColor = repressioneColor
            default:
                self.topView.setLayerColors(happyGradientColor)
            }
            self.topView.corner(byRoundingCorners: [.bottomLeft,.bottomRight], radii: 20.fit)
        }
        
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
        emotionValue.text = "情绪值 \(data.mood)"
    }
    
    public func hiddenUI(){
        UIView.animate(withDuration: 0.5) {
            DispatchQueue.main.async {
                self.topView.corner(byRoundingCorners: [.bottomLeft,.bottomRight], radii: 0)
            }
            self.setAlpha(for: [self.day,self.week,self.yearMouth,self.rightView,self.emotionValue], with: 0)
        }
    }
    public func showUI(){
        UIView.animate(withDuration: 0.5) {
            self.setAlpha(for: [self.day,self.week,self.yearMouth,self.rightView,self.emotionValue], with: 1)
            DispatchQueue.main.async {
                self.topView.corner(byRoundingCorners: [.bottomLeft,.bottomRight], radii: 20.fit)
            }
        }
    }
    private func setAlpha(for views:[UIView],with value:CGFloat) {
        views.forEach { (view) in
            view.alpha = value
        }
    }
}

