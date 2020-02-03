//
//  MineChartCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/26.
//  Copyright © 2019 张驰. All rights reserved.
//

import Foundation

import UIKit

class MineChartCell: UIView {
    
    lazy var topView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.red
        vi.cornerRadius = 4
        return vi
    }()
    lazy var day:UILabel = {
        let label = UILabel()
        label.text = "4"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var bottomView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.red
        vi.cornerRadius = 4
        return vi
    }()
    
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(with data:emotionChartModel){
        
        if data.bottomValue == 0 {
            bottomView.backgroundColor = UIColor.clear
            topView.snp.makeConstraints{(make) in
                make.height.equalTo(data.topValue*4/5)
            }
            topView.backgroundColor = data.color
        }
        else {
            topView.backgroundColor = UIColor.clear
            bottomView.snp.makeConstraints{(make) in
                make.height.equalTo(data.bottomValue*4/5)
            }
            bottomView.backgroundColor = data.color
        }
        day.text = data.day
        
        
    }
    
    func configUI(){
        addSubview(topView)
        addSubview(day)
        addSubview(bottomView)
        
        day.snp.makeConstraints{(make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(8.fit)
            //make..equalTo(10)
        }
        topView.snp.makeConstraints{(make) in
            make.centerX.equalTo(day.snp.centerX)
            make.bottom.equalTo(day.snp.top).offset(-2.fit)
            make.width.equalTo(6.fit)
            make.height.equalTo(50.fit)
        }
        
        bottomView.snp.makeConstraints{(make) in
            make.centerX.equalTo(day.snp.centerX)
            make.top.equalTo(day.snp.bottom).offset(2.fit)
            make.width.equalTo(6.fit)
            make.height.equalTo(50.fit)
        }
    }
    
    func configShadow(){
        
    }
    
}
