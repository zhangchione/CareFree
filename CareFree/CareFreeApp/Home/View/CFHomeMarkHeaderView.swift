//
//  CFHomeMarkHeaderView.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/15.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class CFHomeMarkHeaderView: UICollectionReusableView {
        // 标题
         var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.init(name: "PingFangSC-Semibold", size: 24.fit)
            label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
            
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setUpUI(){
            self.addSubview(titleLabel)
            self.titleLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.snp.centerY)
                make.left.equalTo(20.fit)
                make.width.equalTo(300.fit)
                make.height.equalTo(30.fit)
            }
        }
}
