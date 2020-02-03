//
//  ItemHeaderView.swift
//  CareFree
//
//  Created by 张驰 on 2020/2/2.
//  Copyright © 2020 张驰. All rights reserved.
//

import Foundation
import UIKit

class ItemHeaderView: UICollectionReusableView {
    // 标题
     var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20)
        label.textColor = UIColor.init(r: 56, g: 56, b: 56 )
        
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        self.backgroundColor = UIColor.init(r: 247, g: 249, b: 254)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(0)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}
