//
//  ValueView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/13.
//  Copyright © 2020 张驰. All rights reserved.
//


import UIKit


enum ValueType {
    case left,rightEmotion,rightNomnal
}


class ValueView: UIView {
    
    
    public func updateUI(value:Int,valueLabel:String,type:ValueType){
        
        self.value.text = "\(value)"
        self.valueLabel.text = valueLabel
        
        switch type {
        case .left:
            break;
        case .rightEmotion:
            self.value.textColor = .white
            self.value.textAlignment = .right
            self.valueLabel.textAlignment = .right
            self.valueLabel.textColor = .white
            self.lineView.snp.remakeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY).offset(2.fit)
                make.right.equalTo(self).offset(-2.fit)
                make.width.equalTo(10.fit)
                make.height.equalTo(2.fit)
            }
            self.lineView.backgroundColor = .white
        case .rightNomnal:
            break;
        }
    }
    
    
    lazy var value:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "36"
        label.textAlignment = .left
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 16.fit)
        return label
    }()
    lazy var lineView:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.black
        return vi
    }()
    lazy var valueLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(r: 85, g: 85, b: 85)
        label.text = "Point"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.init(name: "PingFangSC-Medium", size: 12.fit)
        return label
    }()
    

    
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(value)
        value.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(0.fit)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(25.fit)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(2.fit)
            make.left.equalTo(self).offset(2.fit)
            make.width.equalTo(10.fit)
            make.height.equalTo(2.fit)
        }
        
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(0.fit)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(20.fit)
        }
        
    }

}
