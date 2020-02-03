//
//  ShowHeaderView.swift
//  CareFree
//
//  Created by 张驰 on 2019/12/1.
//  Copyright © 2019 张驰. All rights reserved.
//

import UIKit

class ShowHeaderView: UITableViewHeaderFooterView {

    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var nowLabel:UILabel = {
        let label = UILabel()
        label.text = "此刻"
        label.font = UIFont(name: "PingFangSC-Semibold", size: 22)
        label.textColor = UIColor.black
         //       label.backgroundColor = UIColor.blue
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView!.backgroundColor = .white
        self.addSubview(self.nowLabel)
        self.nowLabel.text = "此刻"
        self.nowLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
