//
//  SetView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit


enum SetViewOnBodyViewType {
    case taskTop,showTask
}

protocol SetViewOnBodyViewCallBackDelegate:NSObjectProtocol {
    func setCallBack(type:SetViewOnBodyViewType,isOn:Bool)
}


class SetView: UIView {
    
    
    weak var delegate:SetViewOnBodyViewCallBackDelegate?
    
    public func updateUI(title:String){
        self.titleLabel.text = title
    }
    
    public var setViewType:SetViewOnBodyViewType = .showTask
    
    
    lazy var titleLabel:UILabel = {
       let label = UILabel()
        //label.textColor = UIColor.white
        label.font = UIFont.init(name: "PingFangSC-Regular", size: 14.fit)
        label.text = "首页显示任务"
        return label
    }()
    
    
    lazy var controller: UISwitch = {
       let s = UISwitch()
        s.transform = CGAffineTransform(scaleX: 0.6,y: 0.6)
        s.addTarget(self, action: #selector(set), for: .valueChanged)
        return s
    }()

    @objc func set(_ sender:UISwitch) {
        print(sender.isOn)
        delegate?.setCallBack(type: setViewType,isOn: sender.isOn)
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configUI(){
        
        addSubview(controller)
        controller.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(35.fit)
            make.height.equalTo(25.fit)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(controller.snp.left)
            make.height.equalTo(25.fit)
        }
    }
    
    
    
}
