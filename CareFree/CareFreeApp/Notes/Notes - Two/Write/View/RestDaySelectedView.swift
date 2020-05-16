//
//  RestDaySelectedView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/16.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class RestDaySelectedView: UIView {

    typealias callBackBlock = () -> ()
    var callback:callBackBlock?
    
    public func updateUI(with dayValue:Int){
        self.detailLabel.text = "\(dayValue)天"
    }
    
    lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.text = "倒计时"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14.fit)
        label.textColor = UIColor.black
        label.textAlignment = .left
        return label
    }()
    
    lazy var detailLabel : UILabel = {
       let label = UILabel()
        label.text = "天"
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 12.fit)
        label.textColor = UIColor.init(r: 138, g: 138, b: 138)
        label.textAlignment = .right
        return label
    }()
    
    lazy var rightIcon:UIImageView = {
        let img = UIImageView()
         img.image = UIImage(named: "mine_icon_setright")
         return img
     }()
    
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(0.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        
        addSubview(rightIcon)
        rightIcon.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(0.fit)
            make.centerY.equalTo(self)
            make.height.equalTo(20.fit)
            make.width.equalTo(15.fit)
        }
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20.fit)
             make.centerY.equalTo(self)
            make.height.equalTo(25.fit)
            make.width.equalTo(50.fit)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        self.addGestureRecognizer(tap)
    }
    @objc func back() {
        if let callback = self.callback {
            callback()
        }
    }

}
