//
//  CFHomeMarkCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class CFHomeMarkCell: UICollectionViewCell {
    
    
    public func updateUI(with data:CFNotesModel){
        
        contentLabel.snp.updateConstraints { (make) in
            make.height.equalTo(self.getContentLabelHeigt(with: data.content))
        }
        contentLabel.text = data.content
        
        let date = Date() //data.date
        let timeForMatter = DateFormatter()
        timeForMatter.dateFormat = "MM月dd日"
        let mouthDaytext = timeForMatter.string(from: date)
        timeForMatter.dateFormat = "HH:MM"
        let hourstext = timeForMatter.string(from: date)
        
        mouthDayLabel.text = mouthDaytext
        hoursLabel.text = hourstext
        
        if data.restDay != -1 {
            restDayValue.text = "\(data.restDay)"
            restDay.text = "天"
        }else {
            restDayValue.text = ""
            restDay.text = ""
        }
        
        switch data.priority {
        case 0:
            backView.backgroundColor = shortTimeGradeColor
            updateWhite()
        case 1:
            backView.backgroundColor = firstGradeColor
        case 2:
            backView.backgroundColor = secendGradeColor
        case 3:
            backView.backgroundColor = threeGradeColor
        case 10001:
            backView.backgroundColor = markGradeColor
            
        default:
            backView.backgroundColor = .white
            updateWhite()
        }
        
        
    }
    
    private func updateWhite(){
        self.contentLabel.textColor = UIColor.black
        self.mouthDayLabel.textColor = UIColor.init(r: 103, g: 103, b: 103)
        self.hoursLabel.textColor = UIColor.init(r: 103, g: 103, b: 103)
        self.restDayValue.textColor =  UIColor.black
        self.restDay.textColor = UIColor.black
        self.moreImg.image = UIImage(named: "abc_ic_more_gray_22x22_")
    }
    
    // 背景
    lazy var backView:UIView = {
       let vi = UIView()

        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    
    lazy var contentLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 18.fit)
        label.textColor = .white
        label.text = "距离开学"
        return label
    }()
    
    lazy var mouthDayLabel :UILabel = {
        let label = UILabel()
       label.font = UIFont.init(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = .white
        label.text = "03月28日"
        return label
    }()
    
    lazy var hoursLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = .white
        label.text = "00:22"
        return label
    }()
    
    lazy var line: UIView = {
        let vi = UIView()
        vi.backgroundColor = .white
        vi.alpha = 0.3
        return vi
    }()
    
    lazy var restDayValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 26.fit)
        label.textColor = .white
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    lazy var restDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 16.fit)
        label.textColor = .white
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    lazy var moreImg:UIImageView = {
        let img = UIImageView()
            img.image = UIImage(named: "home_stroy_setmore")
        img.contentMode = .scaleAspectFill
         return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        configShadow()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(backView)

        
        backView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(150.fit)
        }
        addSubview(moreImg)
        moreImg.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-40.fit)
            make.bottom.equalTo(self).offset(-15.fit)
            make.width.equalTo(35.fit)
            make.height.equalTo(25.fit)
        }
        
        addSubview(mouthDayLabel)
        mouthDayLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(40.fit)
            make.centerY.equalTo(moreImg)
            make.width.equalTo(80.fit)
            make.height.equalTo(30.fit)
        }
        
        addSubview(hoursLabel)
        hoursLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(140.fit)
            make.centerY.equalTo(moreImg)
            make.width.equalTo(60.fit)
            make.height.equalTo(30.fit)
        }
        
        addSubview(line)
        line.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-40.fit)
            make.left.equalTo(self).offset(40.fit)
            make.bottom.equalTo(self).offset(-45.fit)
            make.height.equalTo(2.fit)
        }
        
        addSubview(restDay)
        restDay.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-40.fit)
            make.bottom.equalTo(self).offset(-80.fit)
            make.width.equalTo(25.fit)
            make.height.equalTo(30.fit)
        }
        addSubview(restDayValue)
        restDayValue.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-65.fit)
            make.bottom.equalTo(restDay.snp.bottom)
            make.width.equalTo(35.fit)
            make.height.equalTo(35.fit)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(40.fit)
            make.bottom.equalTo(restDay.snp.bottom)
            make.width.equalTo(250.fit)
            make.height.equalTo(30.fit)
        }
        
    }
    
    private func configShadow(){
        self.backView.backgroundColor = .white
        self.backView.layer.cornerRadius = 15.fit
        self.backView.layer.masksToBounds = false
        self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        self.backView.layer.shadowOpacity = 1
        self.backView.layer.shadowRadius = 12.fit
    }
    
    private func getContentLabelHeigt(with text:String) -> CGFloat {
        let height = getTextHeight(textStr: text, font: UIFont.init(name: "PingFangSC-Regular", size: 18.fit)!, width: 250.fit)
        return height
    }
}
