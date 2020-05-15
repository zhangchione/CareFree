//
//  CFHomeMarkCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class CFHomeMarkCell: UICollectionViewCell {
    
    
    public func updateUI(){
        backView.backgroundColor = UIColor.init(r: 247, g: 115, b: 152)
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
        return vi
    }()
    
    lazy var restDayValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 26.fit)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "30"
        return label
    }()
    lazy var restDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 16.fit)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "天"
        return label
    }()
    
    lazy var moreBtn:UIButton = {
        let btn = UIButton()
         btn.setTitle("。。。", for: .normal)
         btn.setTitleColor(UIColor.white, for: .normal)
         return btn
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
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints{(make) in
            make.right.equalTo(self).offset(-40.fit)
            make.bottom.equalTo(self).offset(-15.fit)
            make.width.equalTo(30.fit)
            make.height.equalTo(20.fit)
        }
        
        addSubview(mouthDayLabel)
        mouthDayLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(40.fit)
            make.centerY.equalTo(moreBtn)
            make.width.equalTo(80.fit)
            make.height.equalTo(20.fit)
        }
        
        addSubview(hoursLabel)
        hoursLabel.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(140.fit)
            make.centerY.equalTo(moreBtn)
            make.width.equalTo(60.fit)
            make.height.equalTo(20.fit)
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
            make.width.equalTo(100.fit)
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
}
