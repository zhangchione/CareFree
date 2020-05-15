//
//  CFHomeMoodValueCell.swift
//  CareFree
//
//  Created by zhangchi06 on 2020/5/14.
//  Copyright © 2020 张驰. All rights reserved.
//

import UIKit

class CFHomeMoodValueCell: UICollectionViewCell {
    // 背景
    lazy var backView:UIView = {
       let vi = UIView()
        vi.backgroundColor = UIColor.white
        vi.layer.cornerRadius = 15.fit
        return vi
    }()
    
    lazy var chartLabel :UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.fit)
        label.textColor = .black
        label.text = "情绪报表"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        
    }
}
