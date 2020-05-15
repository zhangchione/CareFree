//
//  emotionChartCell.swift
//  CareFree
//
//  Created by 张驰 on 2019/6/12.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit


struct EmotionChartModel {
    var dayText = ""
    var mood = 0
}

class EmotionChartCell: UIView {

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
        label.textAlignment = .center
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
    
    func updateUI(with data:EmotionChartModel){
        
        
        
        switch data.mood {
            case 26 ... 50:
                topView.backgroundColor = happyColor
            case 0 ... 25:
                topView.backgroundColor = calmColor
            case -25 ... -1:
                bottomView.backgroundColor = sadColor
            case -50 ... -26:
                bottomView.backgroundColor = repressioneColor
            default:
                break
        }
        
        if data.mood > 0 {
            topView.snp.makeConstraints{(make) in
                make.height.equalTo((data.mood*2).fit)
            }
            bottomView.backgroundColor = UIColor.clear
        }else if data.mood < 0 {
            topView.backgroundColor = UIColor.clear
            bottomView.snp.makeConstraints{(make) in
                make.height.equalTo((abs(data.mood)*2).fit)
            }
        }else {
            bottomView.backgroundColor = UIColor.clear
            topView.backgroundColor = UIColor.clear
        }
        day.text = data.dayText
    }
    
    func configUI(){
        addSubview(topView)
        addSubview(day)
        addSubview(bottomView)
        
        day.snp.makeConstraints{(make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(20.fit)
            make.height.equalTo(15.fit)
        }
        topView.snp.makeConstraints{(make) in
            make.centerX.equalTo(day.snp.centerX)
            make.bottom.equalTo(day.snp.top).offset(-2.fit)
            make.width.equalTo(10.fit)
            make.height.equalTo(100.fit)
        }
        
        bottomView.snp.makeConstraints{(make) in
            make.centerX.equalTo(day.snp.centerX)
            make.top.equalTo(day.snp.bottom).offset(2.fit)
            make.width.equalTo(10.fit)
            make.height.equalTo(100.fit)
        }
        //self.backgroundColor = .red
    }
    
    func configShadow(){
        
    }

}
