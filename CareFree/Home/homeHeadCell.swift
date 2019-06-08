//
//  homeHeadCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/8.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class homeHeadCell: UIView {


    lazy var topView:UIView = {
       let vi = UIView()
        vi.backgroundColor = .green
        vi.layer.cornerRadius = 15
        return vi
    }()
    lazy var line:UIView = {
        let vi = UIView()
        vi.backgroundColor = .red
        return vi
    }()
    // 心情圆
    
    
    
    lazy var emotionValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.text = "36"
        return label
    }()
    
    lazy var favImg:UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "favor")
        return img
    }()
    
    lazy var valueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = "当前情绪值"
        return label
    }()
    lazy var nowEmotionValue:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        label.text = "36"
        return label
    }()
    
    // 情绪报表
    lazy var chartView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15
        return vi
    }()
    
    lazy var chartLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "情绪报表"
        return label
    }()
    
    lazy var chartMoreBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(UIColor.init(r: 73, g: 73, b: 73), for: .normal)
        return btn
    }()
    
    // 情绪图
    
    
    
    lazy var recommendLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.init(r: 103, g: 103, b: 103)
        label.text = "最近一周情绪波动较大,需要适当调整情绪"
        return label
    }()
    
    // 底部文字
    lazy var todayRecommend:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.text = "今日推荐"
        return label
    }()
    lazy var todayRecommendMoreBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(UIColor.init(r: 73, g: 73, b: 73), for: .normal)
        return btn
    }()
    
    
    init() {
        super.init(frame: .zero)
        configUI()
        configShaow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configUI(){
        addSubview(topView)
        topView.addSubview(line)
        topView.addSubview(emotionValue)
        topView.addSubview(favImg)
        topView.addSubview(valueLabel)
        topView.addSubview(nowEmotionValue)
        
        addSubview(chartView)
        chartView.addSubview(chartLabel)
        chartView.addSubview(chartMoreBtn)
        chartView.addSubview(recommendLabel)
        
        addSubview(todayRecommend)
        addSubview(todayRecommendMoreBtn)
        
        topView.snp.makeConstraints{(make) in
            make.left.top.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.height.equalTo(200)
        }
        line.snp.makeConstraints{(make) in
            make.left.equalTo(topView.snp.left).offset(10)
            make.centerY.equalTo(topView.snp.centerY)
            make.height.equalTo(120)
            make.width.equalTo(1.5)
        }
        emotionValue.snp.makeConstraints{(make) in
            make.left.equalTo(line).offset(60)
            make.centerY.equalTo(line.snp.centerY)
            make.height.width.equalTo(40)
        }
        favImg.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(line.snp.top).offset(5)
            make.height.width.equalTo(20)
        }
        valueLabel.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(favImg.snp.bottom).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        nowEmotionValue.snp.makeConstraints{(make) in
            make.right.equalTo(topView.snp.right).offset(-40)
            make.top.equalTo(valueLabel.snp.bottom).offset(5)
            make.width.height.equalTo(40)
        }
        
        
        chartView.snp.makeConstraints{(make) in
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(topView.snp.bottom).offset(25)
            make.height.equalTo(300)
        }
        chartLabel.snp.makeConstraints{(make) in
            make.left.equalTo(chartView.snp.left).offset(10)
            make.top.equalTo(chartView.snp.top).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        chartMoreBtn.snp.makeConstraints{(make) in
            make.right.equalTo(chartView.snp.right).offset(-20)
            make.centerY.equalTo(chartLabel.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        recommendLabel.snp.makeConstraints{(make) in
            make.bottom.equalTo(chartView.snp.bottom).offset(-15)
            make.left.equalTo(chartView.snp.left).offset(10)
            make.right.equalTo(chartView.snp.right).offset(-10)
        }
        
        todayRecommend.snp.makeConstraints{(make) in
            make.top.equalTo(chartView.snp.bottom).offset(30)
            make.left.equalTo(self).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        todayRecommendMoreBtn.snp.makeConstraints{(make) in
            make.centerY.equalTo(todayRecommend.snp.centerY)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(50)
            make.height.equalTo(25)
        }
        
        
    }
    func configShaow(){
        
    }
    func updateUI(){
        
    }
}
