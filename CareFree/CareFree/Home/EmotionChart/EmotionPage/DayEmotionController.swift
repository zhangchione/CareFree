//
//  DayEmotionController.swift
//  CareFree
//
//  Created by 张驰 on 2019/7/29.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit
import CollectionKit
import SnapKit

class DayEmotionController: UIViewController {

    lazy var emotionView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var viewLeftBtn: UIButton = {
       let button = UIButton()
        
        return button
    }()
    
    lazy var viewRightBtn:UIButton = {
       let button = UIButton()
        return button
    }()
    
    lazy var titleTime:UILabel = {
       let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 12)
        label.textColor = UIColor.init(r: 111, g: 111, b: 111)
        label.text = "2019年6月3日至9日"
        label.textAlignment = .center
        return label
    }()
    
    lazy var emotionSummary:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        label.textColor = UIColor.init(r: 73, g: 73, b: 73)
        label.text = "最近一周情绪波动较大，但总体情绪处于积极状态。"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tip:UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14)
        label.textColor = UIColor.init(r: 73, g: 73, b: 73)
        label.text = "积极的运动有利于调节自己的情绪，稳定自己的心情，保 持充足的睡眠更是重要，当精力不足时，不仅工作没有效 率，更容易出现沮丧，烦躁的情绪。"
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI(){
         view.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
        view.addSubview(emotionView)
        emotionView.snp.makeConstraints{(make) in
            make.left.equalTo(view)
            make.top.equalTo(view).offset(10)
            make.height.equalTo(300)
            make.right.equalTo(view)
        }
        emotionView.addSubview(viewLeftBtn)
        viewLeftBtn.snp.makeConstraints{(make) in
            make.left.equalTo(emotionView.snp.left).offset(10)
            make.top.equalTo(emotionView.snp.top).offset(10)
            make.height.width.equalTo(10)
        }
        emotionView.addSubview(viewRightBtn)
        viewRightBtn.snp.makeConstraints{(make) in
            make.right.equalTo(emotionView.snp.right).offset(-10)
            make.top.equalTo(emotionView.snp.top).offset(10)
            make.height.width.equalTo(10)
        }
        emotionView.addSubview(titleTime)
        titleTime.snp.makeConstraints{(make) in
            make.centerX.equalTo(emotionView.snp.centerX)
            make.top.equalTo(emotionView.snp.top).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(200)
        }
        view.addSubview(emotionSummary)
        emotionSummary.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(emotionView.snp.bottom).offset(40)
            make.height.equalTo(30)
            make.width.equalTo(374)
        }
        view.addSubview(tip)
        tip.snp.makeConstraints{(make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(emotionSummary.snp.bottom).offset(10)
            make.height.equalTo(100)
            make.width.equalTo(374)
        }
    }

}
